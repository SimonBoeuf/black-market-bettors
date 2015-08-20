class Event < ActiveRecord::Base
  has_many :participants
  #attr_accessible :ascendedType, :buildingType, :creatorId, :eventType, :itemAfter, :itemBefore, :itemId, :killerId, :laneType, :levelUpType, :monsterType, :participantId, :pointCaptured, :position, :skillSlot, :teamId, :timestamp, :towerType, :victimId, :wardType
end
