class Team < ActiveRecord::Base
  has_many :bans, class_name: 'StaticData::Champion'
  #attr_accessible :teamId
end
