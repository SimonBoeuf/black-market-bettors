class RunePoint < ActiveRecord::Base
  belongs_to :participant
  belongs_to :rune, :class_name => 'StaticData::Mastery'
  #attr_accessible :rank
end
