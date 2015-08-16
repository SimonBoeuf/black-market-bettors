class RiotApi::FeaturedGames < RiotApi

  def self.get_featured_games args
    check_args args, [:region]
    url = "#{base_featured_games_url(args[:region])}"
    get_api_response(url)
  end

  protected
  def self.base_featured_games_url region
    "https://#{region}.api.pvp.net/observer-mode/rest/featured"
  end

end