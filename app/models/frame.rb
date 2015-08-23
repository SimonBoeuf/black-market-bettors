class Frame < ActiveRecord::Base
  has_many :events
  has_many :participant_frames
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
    p['participant_frames'] = ParticipantFrame.build_from_array(json['participantFrames'], game_id) if json['participantFrames']
    p['events'] = Event.build_from_array(json['events'],game_id) if json['events']
    create(p)
  end
end
