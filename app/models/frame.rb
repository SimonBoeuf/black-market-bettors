class Frame < ActiveRecord::Base
  has_many :events
  belongs_to :timeline
  #attr_accessible :timestamp
end
