class MasteryPoint < ActiveRecord::Base
  belongs_to :participant
  belongs_to :mastery, :class_name => 'StaticData::Mastery'
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
    p['mastery'] = StaticData::Mastery.find_or_build_by_id(json['masteryId'])
    create(p)
  end

  def self.atomic_attributes
    ["rank"]
  end
end

