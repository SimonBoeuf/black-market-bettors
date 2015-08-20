class MasteryPoint < ActiveRecord::Base
  belongs_to :participant
  belongs_to :mastery, :class_name => 'StaticData::Mastery'
  #attr_accessible :rank
end