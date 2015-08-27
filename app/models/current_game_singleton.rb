require 'singleton'
require 'observer'
class CurrentGameSingleton
  include Singleton
  include Observable

  def initialize
    @status = :loading
    region = SAMPLE_MATCHES.to_a.sample.first
    json = RiotApi::Match.get_by_id({region: region.downcase, id: SAMPLE_MATCHES[region].sample}, {includeTimeline: true})
    @champions = get_champions_from_json json
    changed
    notify_observers({status: "loading", data: @champions})
    Thread.new do
      load_game json
      ActiveRecord::Base.connection.close
    end
  end

  def load_game json
    @game = Game.find_or_build_from_json json
    @game_state = @game.to_hash
    @msg = @game.get_next_msg({frame: nil, msg: nil})
    @next_msg = @game.get_next_msg(@msg)
    @status = :running
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
    changed
    notify_observers({status: "ended", type: "summary", data: @game.winning_team})
    initialize
  end

  def status
    @status
  end

  def champions
    @champions
  end

  def game_state
    @game_state
  end

  def game
    @game
  end

  def format_msg
    {status: "running", type: @msg[:event] ? "event" : "frame", data: @msg[:event] || @msg[:frame], wait: get_next_timestamp}
  end

  def launch_next_msg
    @msg = @next_msg
    @next_msg = @game.get_next_msg(@msg)
    process_event
    changed
    notify_observers(format_msg)
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
      a.append StaticData::Champion.find_or_build_by_id p['championId']
    end
    return a
  end

  def get_next_timestamp
    return 0 if !@msg[:frame] || !@next_msg[:frame]
    current_timestamp =  @msg[:event] ? @msg[:event].timestamp : @msg[:frame].timestamp
    next_timestamp = @next_msg[:event] ? @next_msg[:event].timestamp : @next_msg[:frame].timestamp
    (next_timestamp - current_timestamp) / 1000 / GAME_SPEED
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
        when "ITEM_DESTROYED" || "ITEM_SOLD" || "ITEM_UNDO"
          process_item_remove(event)
        when "ITEM_PURCHASED"
          process_item_add(event)
        when "SKILL_LEVEL_UP" && event.NORMAL?
          process_skill_level_up(event)
      end
    else
      process_frame @msg[:frame] if @msg[:frame]
    end
  end

  def process_building_kill event
    if event.TOWER_BUILDING?
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
    #TODO process brawler
  end

  def process_item_add event
    #TODO process brawler
  end

  def process_skill_level_up event
    get_participant(event.participant.id)[:level] += 1
  end

  def process_frame frame
    @game_state[:blue_team][:gold] = frame.total_gold(:blue_team)
    @game_state[:blue_team][:gold] = frame.total_gold(:red_team)
    #TODO : Check participants levels ?
  end

  def get_participant id
    @game_state[Team.get_color_by_participant(id)][:participants].select{|p| p[:participantId] == id}.first
  end
end