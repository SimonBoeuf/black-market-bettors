class StaticData::Rune < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  #attr_accessible :name
end
