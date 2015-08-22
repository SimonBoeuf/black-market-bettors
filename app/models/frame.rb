class Frame < ActiveRecord::Base
  has_many :events
  belongs_to :timeline
  #attr_accessible :timestamp
  def self.build_from_array array, game_id
    res = []
    array.each do |json|
      res.append build_from_json(json, game_id)
    end
    res
  end

  def self.build_from_json json, game_id
    p = {}
    p['timestamp'] = json['timestamp']
    p['events'] = Event.build_from_array(json['events'],game_id) if json['events']
    create(p)
  end
end
