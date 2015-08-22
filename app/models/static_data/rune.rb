class StaticData::Rune < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  #attr_accessible :name

  def self.find_or_build_by_id id
    r = find_by_id(id)
    return r unless r.nil?
    res = RiotApi::Static_Data.get_rune_by_id({id: id}, {runeData: 'image'})
    p = res.select{|k, v| atomic_attributes.include? k}
    p['image'] = StaticData::Image.build_from_json res['image']
    create(p)
  end


  def self.atomic_attributes
    ["id", "type", "name"]
  end

  private_class_method :atomic_attributes
end
