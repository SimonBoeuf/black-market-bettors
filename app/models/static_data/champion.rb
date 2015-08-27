class StaticData::Champion < StaticData
  belongs_to :image, dependent: :destroy
  has_many :skins, dependent: :destroy

  def self.find_or_build_by_id id
    r = find_by_id(id)
    return r unless r.nil?
    res = RiotApi::Static_Data.get_champion_by_id({id: id}, {champData: 'image'})
    p = res.select{|k, v| atomic_attributes.include? k}
    p['image'] = StaticData::Image.build_from_json res['image']
    create(p)
  end

  def self.get_splash_image img, name, skin_num, region
    res = RiotApi::Static_Data.get_realm({region: region})
    "#{res['cdn']}/img/#{img.group}/splash/#{name}_#{skin_num}.jpg"
  end

  def self.get_loading_image img, name, skin_num, region
    res = RiotApi::Static_Data.get_realm({region: region})
    "#{res['cdn']}/img/#{img.group}/loading/#{name}_#{skin_num}.jpg"
  end

  def self.atomic_attributes
    ["id", "name", "key", "title"]
  end

  private_class_method :atomic_attributes
end
