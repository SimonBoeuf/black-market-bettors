class StaticData::Mastery < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  enum mastery_tree: [:Defense, :Offense, :Utility]
end
