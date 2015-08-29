class StaticData::Image < StaticData
  def self.build_from_json json
    p = json.select{|k, v| atomic_attributes.include? k}
    create(p)
  end

  def self.get_full_image img, region = "euw"
    "#{self.class.get_base_dragon_url(region)}/img/#{img.group}/#{img.full}"
  end

  def get_sprite_style region = "euw"
    "width:#{w}px;height:#{h}px;background: url(#{self.class.get_base_dragon_url(region)}/img/sprite/#{sprite}); background-repeat:no-repeat;background-position:-#{x}px -#{y}px;"
  end

  def self.atomic_attributes
    ["id", "full", "sprite", "group", "x", "y", "w", "h"]
  end
end
