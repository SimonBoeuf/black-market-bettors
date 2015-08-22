class StaticData::Mastery < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  enum mastery_tree: [:Defense, :Offense, :Utility]

  def self.find_or_build_by_id id
    r = find_by_id(id)
    return r unless r.nil?
    res = RiotApi::Static_Data.get_mastery_by_id({id: id}, {masteryData: 'all'})
    p = Hash[res.map{|k, v| [k.underscore, v]}].select{|k, v| atomic_attributes.include? k}
    p['image'] = StaticData::Image.build_from_json res['image']
    create(p)
  end


  def self.atomic_attributes
    ["id", "mastery_tree", "name"]
  end

  private_class_method :atomic_attributes
end
