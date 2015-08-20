class Event < ActiveRecord::Base
  belongs_to :frame
  belongs_to :participant
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

  #attr_accessible :creatorId, :itemAfter, :itemBefore, :itemId, :killerId, :participantId, :position, :skillSlot, :teamId, :timestamp, :towerType, :victimId, :wardType
end