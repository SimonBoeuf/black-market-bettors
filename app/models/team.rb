class Team < ActiveRecord::Base
  has_many :bans, class_name: 'StaticData::Champion'
  belongs_to :game
  #attr_accessible :teamId
end
