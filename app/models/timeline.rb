class Timeline < ActiveRecord::Base
  has_many :frames
  belongs_to :game
  #attr_accessible :frameInterval
end
