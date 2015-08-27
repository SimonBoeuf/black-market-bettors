class Event < ActiveRecord::Base
  belongs_to :frame
  belongs_to :participant
  belongs_to :team
  belongs_to :item, :class_name => 'StaticData::Item'

  has_and_belongs_to_many :assisting_participants, join_table: 'events_participants', class_name: 'Participant'
  enum ascendedType: [ :CHAMPION_ASCENDED, :CLEAR_ASCENDED, :MINION_ASCENDED ]
  enum buildingType: [:INHIBITOR_BUILDING, :TOWER_BUILDING]
  enum eventType: [:ASCENDED_EVENT, :BUILDING_KILL, :CAPTURE_POINT, :CHAMPION_KILL, :ELITE_MONSTER_KILL, :ITEM_DESTROYED, :ITEM_PURCHASED, :ITEM_SOLD, :ITEM_UNDO, :PORO_KING_SUMMON, :SKILL_LEVEL_UP, :WARD_KILL, :WARD_PLACED]
  enum laneType: [:BOT_LANE, :MID_LANE, :TOP_LANE]
  enum levelUpType: [:EVOLVE, :NORMAL]
  enum monsterType: [:BARON_NASHOR, :BLUE_GOLEM, :DRAGON, :RED_LIZARD, :VILEMAW]
  enum pointCaptured: [:POINT_A, :POINT_B, :POINT_C, :POINT_D, :POINT_E]
  enum towerType: [:BASE_TURRET, :FOUNTAIN_TURRET, :INNER_TURRET, :NEXUS_TURRET, :OUTER_TURRET, :UNDEFINED_TURRET]
  enum wardType: [:SIGHT_WARD, :TEEMO_MUSHROOM, :UNDEFINED, :VISION_WARD, :YELLOW_TRINKET, :YELLOW_TRINKET_UPGRADE]

  scope :allowed_msg, -> { where(eventType: allowed_types) }


  #attr_accessible :creatorId, :itemAfter, :itemBefore, :itemId, :killerId, :position, :skillSlot, :timestamp, :towerType, :victimId, :wardType
  def self.build_from_array array, game_id
    res = []
    array.each do |json|
      res.append build_from_json(json, game_id)
    end
    res
  end

  def self.build_from_json json, game_id
    p = json.select{|k, v| atomic_attributes.include? k}
    p['positionX'] = json['position']['x'] if json['position']
    p['positionY'] = json['position']['y'] if json['position']
    p['participant'] = Participant.where(game_id: game_id, participantId: json['participantId']).first
    p['item'] = StaticData::Item.find_or_build_by_id(json['itemId']) if json['itemId'] && json['itemId'] != 1501 #404
    if json['assistingParticipantIds']
      p['assisting_participants'] = []
      json['assistingParticipantIds'].each do |participantId|
        p['assisting_participants'].append Participant.where(game_id: game_id, participantId: participantId).first
      end
    end
    create(p)
  end

  def self.allowed_types
    #[:BUILDING_KILL, :CHAMPION_KILL, :ELITE_MONSTER_KILL, :ITEM_DESTROYED, :ITEM_PURCHASED, :ITEM_SOLD, :ITEM_UNDO, :SKILL_LEVEL_UP] #This should work??
    [Event.eventTypes[:BUILDING_KILL], Event.eventTypes[:CHAMPION_KILL], Event.eventTypes[:ELITE_MONSTER_KILL],
     Event.eventTypes[:ITEM_DESTROYED], Event.eventTypes[:ITEM_PURCHASED], Event.eventTypes[:ITEM_SOLD], Event.eventTypes[:ITEM_UNDO],
     Event.eventTypes[:SKILL_LEVEL_UP]]
  end

  def self.atomic_attributes
    ["ascendedType", "buildingType", "eventType", "laneType", "levelUpType", "monsterType", "pointCaptured", "towerType", "wardType", "creatorId",
     "itemAfter", "itemBefore", "killerId", "skillSlot", "teamId", "timestamp", "towerType", "victimId", "wardType" ]
  end


  private_class_method :atomic_attributes
end
