class RiotApi::Current_Game < RiotApi

  def self.get_current_game_info args
    check_args args, [:platformId, :summonerId, :region]
    url = "#{base_current_game_url(args[:region])}/getSpectatorGameInfo/#{args[:platformId]}/#{args[:summonerId]}"
    get_api_response(url)
  end

  protected
  def self.base_current_game_url region
    "https://#{region}.api.pvp.net/observer-mode/rest/consumer"
  end

end