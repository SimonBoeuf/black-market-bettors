class RunePoint < ActiveRecord::Base
  belongs_to :participant
  belongs_to :rune, :class_name => 'StaticData::Rune'
  #attr_accessible :rank
  def self.build_from_array array
    res = []
    array.each do |json|
      res.append build_from_json(json)
    end
    res
  end

  def self.build_from_json json
    p = json.select{|k, v| atomic_attributes.include? k}
    p['rune'] = StaticData::Rune.find_or_build_by_id(json['runeId'])
    create(p)
  end

  def self.atomic_attributes
    ["rank"]
  end

  private_class_method :atomic_attributes
end
