require 'singleton'
class CurrentGameSingleton
  include Singleton
  def initialize
    region = SAMPLE_MATCHES.to_a.sample.first
    json = RiotApi::Match.get_by_id({region: region.downcase, id: SAMPLE_MATCHES[region].sample}, {includeTimeline: true})
    @game = Game.build_from_json json
  end

  def game
    @game
  end

  def reload_game
    initialize
  end

  def log
    ap @game
  end
end