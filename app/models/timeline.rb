class Timeline < ActiveRecord::Base
  has_many :frames
  #attr_accessible :frameInterval
end
