class Timeline < ActiveRecord::Base
  has_many :frames, dependent: :destroy
  belongs_to :game
  #attr_accessible :frameInterval

  def self.build_from_json json
    p = Hash[json.map{|k, v| [k.underscore, v]}].select{|k, v| atomic_attributes.include? k}
    p['frames'] = Frame.build_from_array(json['frames'], json['game_id']) if json['frames']
    create(p)
  end

  def self.atomic_attributes
    ["game_id", "frame_interval"]
  end

  private_class_method :atomic_attributes
end
