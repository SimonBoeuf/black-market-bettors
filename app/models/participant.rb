class Participant < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :spell1, class_name: 'StaticData::SummonerSpell'
  belongs_to :spell2, class_name: 'StaticData::SummonerSpell'
  belongs_to :champion, :class_name => 'StaticData::Champion'
  has_many :mastery_points
  has_many :rune_points
  has_and_belongs_to_many :events
  enum highestAchievedSeasonTier: [ :CHALLENGER, :MASTER, :DIAMOND, :PLATINUM, :GOLD, :SILVER, :BRONZE, :UNRANKED]
  #belongs_to :participant_stats
  #attr_accessible :, :participantId
end
