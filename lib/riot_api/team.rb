class RiotApi::Team < RiotApi

  def self.get_by_summoners_ids args
    check_args args, [:ids, :region]
    url = "#{base_team_url(args[:region])}/by-summoner/#{args[:ids]}"
    get_api_response(url)
  end

  def self.get_by_teams_ids args
    check_args args, [:ids, :region]
    url = "#{base_team_url(args[:region])}/#{args[:ids]}"
    get_api_response(url)
  end

  def self.base_team_url region
    "#{base_url region}/v2.4/team"
  end

  private_class_method :base_team_url
end