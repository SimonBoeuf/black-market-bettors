class RiotApi::Game < RiotApi
  def self.get_recent args
    check_args args, [:id, :region]
    url = "#{base_champion_url(args[:region])}/by-summoner/#{args[:id]}/recent"
    get_api_response(url)
  end

  def self.base_champion_url region
    "#{base_url region}/v1.3/game"
  end

  private_class_method :base_champion_url
end