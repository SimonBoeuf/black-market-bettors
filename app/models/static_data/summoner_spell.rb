class StaticData::SummonerSpell < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  #attr_accessible :name
end
