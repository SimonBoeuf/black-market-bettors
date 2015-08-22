class Team < ActiveRecord::Base
  belongs_to :game
  enum team_id: {BLUE_TEAM: 100, RED_TEAM: 200}

  def self.build_from_json json
    create(Hash[json.map{|k, v| [k.underscore, v]}].select{|k, v| atomic_attributes.include? k})
  end

  def self.atomic_attributes
    ["team_id", "game_id", "winner"]
  end

  private_class_method :atomic_attributes
end
