class RiotApi::League < RiotApi

  def self.get_by_summoner args
    check_args args, [:ids, :region]
    url = "#{base_league_url(args[:region])}/by-summoner/#{args[:ids]}"
    get_api_response(url)
  end

  def self.get_entry_by_summoner args
    check_args args, [:ids, :region]
    url = "#{base_league_url(args[:region])}/by-summoner/#{args[:ids]}/entry"
    get_api_response(url)
  end

  def self.get_by_team args
    check_args args, [:ids, :region]
    url = "#{base_league_url(args[:region])}/by-team/#{args[:ids]}"
    get_api_response(url)
  end

  def self.get_entry_by_team args
    check_args args, [:ids, :region]
    url = "#{base_league_url(args[:region])}/by-team/#{args[:ids]}/entry"
    get_api_response(url)
  end

  def self.get_challenger args
    check_args args, [:region]
    url = "#{base_league_url(args[:region])}/challenger"
    get_api_response(url)
  end

  def self.get_master args
    check_args args, [:region]
    url = "#{base_league_url(args[:region])}/master"
    get_api_response(url)
  end

  protected
  def self.base_league_url region
    "#{base_url region}/v2.5/league"
  end

end