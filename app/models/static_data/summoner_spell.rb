class StaticData::SummonerSpell < StaticData
  belongs_to :image, dependent: :destroy
  #attr_accessible :name

  def self.find_or_build_by_id id
    r = find_by_id(id)
    return r unless r.nil?
    res = RiotApi::Static_Data.get_summoner_spell_by_id({id: id}, {spellData: 'image'})
    p = res.select{|k, v| atomic_attributes.include? k}
    p['image'] = StaticData::Image.build_from_json res['image']
    create(p)
  end


  def self.atomic_attributes
    ["id", "key", "name"]
  end

  private_class_method :atomic_attributes
end
