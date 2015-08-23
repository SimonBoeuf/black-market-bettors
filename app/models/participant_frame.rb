class ParticipantFrame < ActiveRecord::Base
  belongs_to :participant
  belongs_to :frame
  #attr_accessible :totalGold, :level, :minionsKilled, :jungleMinionsKilled

  def self.build_from_array array, game_id
    res = []
    array.each do |json|
      res.append build_from_json(json[1], game_id)
    end
    res
  end

  def self.build_from_json json, game_id
    #participant
    p = json.select{|k, v| atomic_attributes.include? k}
    p['positionX'] = json['position']['x'] if json['position']
    p['positionY'] = json['position']['y'] if json['position']
    p['participant'] = Participant.where(game_id: game_id, participantId: json['participantId']).first
    create(p)
  end

  def self.atomic_attributes
    ["totalGold", "level", "minionsKilled", "jungleMinionsKilled" ]
  end
end
