class StaticData::Item < ActiveRecord::Base
  belongs_to :image, dependent: :destroy

  def self.find_or_build_by_id id
    r = find_by_id(id)
    return r unless r.nil?
    if (res = RiotApi::Static_Data.get_item_by_id({id: id}, {itemData: 'tags,consumed,image,sanitizedDescription'}))
      p = res.select{|k, v| atomic_attributes.include? k}
      p['image'] = StaticData::Image.build_from_json res['image']
      p['consumable'] = true if res['tags'] && res['tags'].include?('Consumable')
      create(p)
    end
  end


  def self.atomic_attributes
    ["id", "consumed", "group", "name", "description", "sanitizedDescription", "plaintext"]
  end

  def is_brawler?
    [3611, 3612, 3613, 3614].include? id
  end

  def is_brawler_upgrade?
    [3615, 3616, 3617].include? id
  end

  private_class_method :atomic_attributes
end
