class Participant < ActiveRecord::Base
  belongs_to :team
  belongs_to :summoner_spell_1, class_name: 'StaticData::SummonerSpell'
  belongs_to :summoner_spell_2, class_name: 'StaticData::SummonerSpell'
  belongs_to :champion, :class_name => 'StaticData::Champion'
  has_many :mastery_points
  has_many :rune_points
  belongs_to :participant_stats
  #attr_accessible :highestAchievedSeasonTier, :participantId
end
