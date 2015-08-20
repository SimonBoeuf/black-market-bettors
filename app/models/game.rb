class Game < ActiveRecord::Base
  has_many :participants
  belongs_to :blue_team, class_name: "Team"
  belongs_to :red_team, class_name: "Team"
  belongs_to :timeline
  #attr_accessible :matchId, :region, :platformId, :matchMode, :matchType, :matchCreation, :queueType, :mapId, :season, :matchVersion

end
