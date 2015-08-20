class Frame < ActiveRecord::Base
  has_many :events
  #attr_accessible :timestamp
end
