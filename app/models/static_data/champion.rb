class StaticData::Champion < StaticData
  belongs_to :image, :class_name => 'StaticData::Image'
  has_many :skins, :class_name => 'StaticData::Skin'

  def self.find_or_build_by_id id
    create if !find_by_id id
  end

  def self.get_splash_image img, name, skin_num, region
    res = RiotApi::Static_Data.get_realm({region: region})
    "#{res['cdn']}/img/#{img.group}/splash/#{name}_#{skin_num}.jpg"
  end

  def self.get_loading_image img, name, skin_num, region
    res = RiotApi::Static_Data.get_realm({region: region})
    "#{res['cdn']}/img/#{img.group}/loading/#{name}_#{skin_num}.jpg"
  end
end
