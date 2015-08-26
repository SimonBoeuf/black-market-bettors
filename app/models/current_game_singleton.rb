require 'singleton'
require 'observer'
class CurrentGameSingleton
  include Singleton
  include Observable
  def initialize
    @status = :loading
    region = SAMPLE_MATCHES.to_a.sample.first
    json = RiotApi::Match.get_by_id({region: region.downcase, id: SAMPLE_MATCHES[region].sample}, {includeTimeline: true})
    @champions = get_champions_from_json json
    Thread.new do
      @game = Game.find_or_build_from_json json
      @start = Time.now.to_i
      @msg = @game.get_next_msg({frame: nil, msg: nil})
      @next_msg = @game.get_next_msg(@msg)
      @status = :running
      Thread.new do
        while @msg[:frame] != nil do
          sleep(get_next_timestamp)
          launch_next_msg
          changed
          notify_observers(format_msg)
        end
        ap "Game finished !"
      end
    end
  end

  def status
    @status
  end

  def champions
    @champions
  end

  private

  def game
    @game
  end


  def format_msg
    {status: "running", type: @msg[:event] ? "event" : "frame", data: @msg[:event] || @msg[:frame], wait: get_next_timestamp}
  end

  def launch_next_msg
    @msg = @next_msg
    @next_msg = @game.get_next_msg(@msg)
  end

  def msg
    @msg
  end

  def next_msg
    @next_msg
  end

  def reload_game
    new
  end

  def get_champions_from_json json
    a = []
    json['participants'].each do |p|
      a.append StaticData::Champion.find_or_build_by_id p['championId']
    end
    return a
  end

  def get_next_timestamp
    current_timestamp =  @msg[:event] ? @msg[:event].timestamp : @msg[:frame].timestamp
    next_timestamp = @next_msg[:event] ? @next_msg[:event].timestamp : @next_msg[:frame].timestamp
    (next_timestamp - current_timestamp) / 1000 / GAME_SPEED
  end

end