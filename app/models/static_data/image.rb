class StaticData::Image < StaticData
  def self.build_from_json json
    p = json.select{|k, v| atomic_attributes.include? k}
    create(p)
  end


  def self.atomic_attributes
    ["id", "full", "sprite", "group", "x", "y", "w", "h"]
  end
end
