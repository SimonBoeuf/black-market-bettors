class StaticData::Champion < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
end
