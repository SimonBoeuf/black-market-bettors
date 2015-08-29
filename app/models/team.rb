class Team < ActiveRecord::Base
  belongs_to :game
  has_many :participants
  enum team_id: {BLUE_TEAM: 100, RED_TEAM: 200}

  def self.build_from_json json
    create(Hash[json.map{|k, v| [k.underscore, v]}].select{|k, v| atomic_attributes.include? k})
  end

  def self.atomic_attributes
    ["team_id", "game_id", "winner"]
  end

  def to_hash
    starting_participants = []
    participants.each do |participant|
      starting_participants.append participant.to_hash
    end
    {participants: starting_participants,
    gold: 0,
    barons: 0,
    drakes: 0,
    total_kills: 0,
    towers: { BASE_TURRET: {BOT_LANE: true, MID_LANE: true, TOP_LANE: true},
              INNER_TURRET: {BOT_LANE: true, MID_LANE: true, TOP_LANE: true},
              OUTER_TURRET: {BOT_LANE: true, MID_LANE: true, TOP_LANE: true},
              NEXUS: {UPPER: true, LOWER: true}},
    inhibs: {BOT_LANE: true, MID_LANE: true, TOP_LANE: true},
    tower_kills: 0
    }
  end

  def self.get_color id
    id == 100 ? :blue_team : :red_team
  end

  def self.get_color_by_participant id
    id < 6 ? :blue_team : :red_team
  end

  private_class_method :atomic_attributes
end
