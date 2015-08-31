require 'singleton'
require 'observer'
class CurrentGameSingleton
  include Singleton
  include Observable

  def status
    @status
  end

  def champions
    @champions
  end

  def game_state
    @game_state || {state: "No game running"}
  end

  def add_bettor bettor
    @bettors.append({id: bettor, bets: []}) if @bettors.select{|b| b[:id] == bettor}.empty?
  end

  def remove_bettor bettor
    @bettors.delete_if{|b| b[:id] == bettor}
  end

  def place_bet bettor, team
    @bettors.select{|b| b[:id] == bettor}.first[:bets].select{|bet| bet[:end_time] == -1}.first[:end_time] = Time.now unless @bettors.select{|b| b[:id] == bettor}.first[:bets].empty?
    @bettors.select{|b| b[:id] == bettor}.first[:bets].append({team: team, start_time: Time.now, end_time: -1})
  end

  def bettor_score bettor
    if @bettors.select{|b| b[:id] == bettor}.first
      score = @bettors.select{|b| b[:id] == bettor}.first[:bets].select{|bet| bet[:team] == @game.winning_team.team_id}.sum{|bet| bet[:end_time].to_f - bet[:start_time].to_f} / @game.matchDuration * 1000 * GAME_SPEED
      score > 1000 ? 1000 : score
    end
  end

  private

  def initialize
    @bettors = []
      if @observer_peers
      @observer_peers.each do |obs|
        add_bettor obs.first.connection.id
      end
    end
    Thread.new do
      load_game
      ActiveRecord::Base.connection.close
    end
  end

  def load_game
    json = nil
    loop do
      region = SAMPLE_MATCHES.to_a.sample.first
      break if (!(json = RiotApi::Match.get_by_id({region: region.downcase, id: SAMPLE_MATCHES[region].sample}, {includeTimeline: true})).nil?)
    end
    @champions = get_champions_from_json json
    change_status :loading
    notify_observers({status: @status, data: @champions})
    @game = Game.find_or_build_from_json json
    @game_state = @game.to_hash
    @msg = @game.get_next_msg({frame: nil, msg: nil})
    @next_msg = @game.get_next_msg(@msg)
    change_status :running
    notify_observers({status: @status, data: @game_state})
    Thread.new do
      run_game
      ActiveRecord::Base.connection.close
    end
  end


  def run_game
    while(@msg[:frame] != nil) do
      sleep(get_next_timestamp)
      launch_next_msg
    end
    change_status :ended
    end_bets
    notify_observers({status: @status, data: @game.winning_team})
    sleep(10)
    initialize
  end

  def launch_next_msg
    @msg = @next_msg
    @next_msg = @game.get_next_msg(@msg)
    process_event
    changed
    notify_observers(format_msg) unless skip_msg
  end

  def game
    @game
  end

  def change_status s
    @status = s
    changed
  end

  def msg
    @msg
  end

  def next_msg
    @next_msg
  end

  def get_champions_from_json json
    a = []
    json['participants'].each do |p|
      a.append StaticData::Champion.find_or_build_by_id(p['championId']).as_json(include: :image)
    end
    return a
  end

  def get_next_timestamp
    return 0 if !@msg[:frame] || !@next_msg[:frame]
    current_timestamp =  @msg[:event] ? @msg[:event].timestamp : @msg[:frame].timestamp
    next_timestamp = @next_msg[:event] ? @next_msg[:event].timestamp : @next_msg[:frame].timestamp
    (next_timestamp - current_timestamp).to_f / 1000 / GAME_SPEED
  end

  def process_event
    if (event = @msg[:event])
      case event.eventType
        when "BUILDING_KILL"
          process_building_kill(event)
        when "CHAMPION_KILL"
          process_champion_kill(event) if event.killerId > 0
        when "ELITE_MONSTER_KILL"
          process_elite_monster_kill(event)
        when "ITEM_DESTROYED"
          process_item_remove(event) unless event.item.nil? #1501 not found
        when "ITEM_SOLD"
          process_item_remove(event) unless event.item.nil? #1501 not found
        when "ITEM_UNDO"
          process_item_remove(event) unless event.item.nil? #1501 not found
        when "ITEM_PURCHASED"
          process_item_add(event) unless event.item.nil? #1501 not found
        when "SKILL_LEVEL_UP"
          process_skill_level_up(event) if event.NORMAL?
      end
    else
      process_frame @msg[:frame] if @msg[:frame]
    end
  end


  def process_building_kill event
    if event.TOWER_BUILDING?
      @game_state[Team.get_color(event.teamId == 100 ? 200 : 100)][:tower_kills] += 1
      if event.NEXUS_TURRET?
        if event.positionX > event.positionY
          @game_state[Team.get_color(event.teamId)][:towers][:NEXUS][:LOWER] = false
        else
          @game_state[Team.get_color(event.teamId)][:towers][:NEXUS][:UPPER] = false
        end
      else
        @game_state[Team.get_color(event.teamId)][:towers][event.towerType.to_sym][event.laneType.to_sym] = false
      end
    else
      @game_state[Team.get_color(event.teamId)][:inhibs][event.laneType.to_sym] = false
    end
  end

  def process_champion_kill event
    get_participant(event.victimId)[:deaths] += 1
    get_participant(event.killerId)[:kills] += 1
    @game_state[Team.get_color_by_participant event.killerId][:total_kills] += 1
    event.assisting_participants.each do |assister|
      get_participant(assister.participantId)[:assists] += 1
    end
  end

  def process_elite_monster_kill event
    @game_state[Team.get_color_by_participant event.killerId][:barons] += 1 if event.BARON_NASHOR?
    @game_state[Team.get_color_by_participant event.killerId][:drakes] += 1 if event.DRAGON?
  end

  def process_item_remove event
    get_participant(event.participant.participantId)[:items].delete_at(get_participant(event.participant.participantId)[:items].map{|item| item["id"]}.index(event.item.id)) unless event.participant.nil? || event.item.nil? || event.item.consumed? || get_participant(event.participant.participantId)[:items].map{|item| item["id"]}.index(event.item.id).nil?
  end

  def process_item_add event
    if event.item.is_brawler?
      get_participant(event.participant.participantId)[:brawler][:type] = StaticData::Item.find_or_build_by_id(event.item.id).as_json(include: :image)
    elsif event.item.is_brawler_upgrade?
      get_participant(event.participant.participantId)[:brawler][:evolve] = StaticData::Item.find_or_build_by_id(event.item.id).as_json(include: :image)
    elsif event.item.group == 'RelicBase'
      get_participant(event.participant.participantId)[:trinket] = StaticData::Item.find_or_build_by_id(event.item.id).as_json(include: :image)
    elsif !event.item.consumed?
      get_participant(event.participant.participantId)[:items].append(StaticData::Item.find_or_build_by_id(event.item.id).as_json(include: :image))
    end
  end

  def process_skill_level_up event
    get_participant(event.participant.participantId)[:level] += 1
  end

  def process_frame frame
    @game_state[:blue_team][:gold] = frame.total_gold(:blue_team)
    @game_state[:red_team][:gold] = frame.total_gold(:red_team)
    #TODO : Check participants levels ?
  end

  def get_participant id
    @game_state[Team.get_color_by_participant(id)][:participants].select{|p| p[:participantId] == id}.first
  end

  def format_msg
    {type: @msg[:event] ? "event" : "frame",
     data: if @msg[:event] then
             @msg[:event].to_hash
           else
             @msg[:frame] ? [@msg[:frame].as_json, {blue_team_gold: @msg[:frame].total_gold(:blue_team)}, {red_team_gold: @msg[:frame].total_gold(:red_team)}].inject(&:merge) : nil
           end,
     wait: get_next_timestamp}
  end

  def skip_msg
    event = @msg[:event]
    (@msg[:frame].nil? && @msg[:event].nil?) ||
        (event &&
            (event.ITEM_DESTROYED? || event.ITEM_SOLD? || event.ITEM_UNDO? || event.ITEM_PURCHASED?) &&
            (!event.item || (!event.item.is_brawler? && !event.item.is_brawler_upgrade? && (event.item.consumed? || event.item.group == 'RelicBase'))))
  end

  def end_bets
    @bettors.each do |bettor|
      bettor[:bets].select{|bet| bet[:end_time] == -1}.each do |current|
        current[:end_time] = Time.now
      end
    end
  end
end
