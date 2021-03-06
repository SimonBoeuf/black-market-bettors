class Game < ActiveRecord::Base
  has_many :participants, dependent: :destroy
  belongs_to :blue_team, class_name: "Team", dependent: :destroy
  belongs_to :red_team, class_name: "Team", dependent: :destroy
  belongs_to :timeline, dependent: :destroy
  enum matchMode: [:CLASSIC, :ODIN, :ARAM, :TUTORIAL, :ONEFORALL, :ASCENCION, :FIRSTBLOOD, :KINGPORO]
  enum matchType: [:CUSTOM_GAME, :MATCHED_GAME, :TUTORIAL_GAME]
  enum queueType: [:CUSTOM, :NORMAL_5x5_BLIND, :RANKED_SOLO_5x5, :RANKED_PREMADE_5x5, :BOT_5x5, :NORMAL_3x3, :RANKED_PREMADE_3x3, :NORMAL_5x5_DRAFT, :ODIN_5x5_BLIND,
                   :ODIN_5x5_DRAFT, :BOT_ODIN_5x5, :BOT_5x5_INTRO, :BOT_5x5_BEGINNER, :BOT_5x5_INTERMEDIATE, :RANKED_TEAM_3x3, :RANKED_TEAM_5x5, :BOT_TT_3x3,
                   :GROUP_FINDER_5x5, :ARAM_5x5, :ONEFORALL_5x5, :FIRSTBLOOD_1x1, :FIRSTBLOOD_2x2, :SR_6x6, :URF_5x5, :ONEFORALL_MIRRORMODE_5x5, :BOT_URF_5x5,
                   :NIGHTMARE_BOT_5x5_RANK1, :NIGHTMARE_BOT_5x5_RANK2, :NIGHTMARE_BOT_5x5_RANK5, :ASCENSION_5x5, :HEXAKILL, :BILGEWATER_ARAM_5x5, :KING_PORO_5x5,
                   :COUNTER_PICK, :BILGEWATER_5x5]
  enum season: [:PRESEASON3, :SEASON3, :PRESEASON2014, :SEASON2014, :PRESEASON2015, :SEASON2015]

  #attr_accessible :matchId, :region, :platformId, :matchCreation, :matchDuration, :mapId, :matchVersion

  def winning_team
    blue_team.winner? ? blue_team : red_team
  end

  def self.find_or_build_from_json json
    find_by_id(json['matchId']) || build_from_json(json)
  end

  def self.build_from_json json
    p = json.select{|k, v| atomic_attributes.include? k}
    game_id = json['matchId']
    p['id'] = game_id
    p['blue_team'] = Team.build_from_json(json['teams'].find{|k| k['teamId'] == 100}.merge({"game_id" => game_id}))
    p['red_team'] = Team.build_from_json(json['teams'].find{|k| k['teamId'] == 200}.merge({"game_id" => game_id}))
    ActiveRecord::Base.transaction do
      @g = create(p)
      @g.participants.append Participant.build_from_array(json['participants'], @g) if json['participants']
      @g.timeline = Timeline.build_from_json(json['timeline'].merge({"game_id" => game_id}))
      @g.save
    end
    return @g
  end

  def self.atomic_attributes
    ["matchId", "region", "platformId", "matchCreation", "matchDuration", "mapId", "matchVersion", "matchMode", "matchType", "queueType", "season"]
  end

  def get_next_msg msg
    next_frame = msg[:frame] ? msg[:event] ? msg[:frame] : timeline.frames.order(:timestamp, :id).where("id > #{msg[:frame].id}").where("timestamp >= #{msg[:frame].timestamp}").first : timeline.frames.order(:timestamp).first
    next_event = msg[:event] ? msg[:frame].events.allowed_msg.order(:timestamp, :id).where("id > #{msg[:event].id}").where("timestamp >= #{msg[:event].timestamp}").first : next_frame.events.order(:timestamp).first if next_frame
    {frame: next_frame, event: next_event}
  end

  def to_hash
    {blue_team: blue_team.to_hash,
     red_team: red_team.to_hash}
  end

  private_class_method :atomic_attributes, :build_from_json

end
