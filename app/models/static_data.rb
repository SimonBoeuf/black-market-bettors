class StaticData < ActiveRecord::Base
  self.abstract_class = true
  def self.table_name_prefix
    'static_data_'
  end
  def self.get_full_image img, region
    "#{get_base_dragon_url(region)}/img/#{img.group}/#{img.full}"
  end

  def self.get_sprite_image img, region
    "#{get_base_dragon_url(region)}/img/sprite/#{img.sprite}"
  end

  def self.get_base_dragon_url region
    res = RiotApi::Static_Data.get_realm({region: region})
    "#{res['cdn']}/#{res['v']}"
  end

end
