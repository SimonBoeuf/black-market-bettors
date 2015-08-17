class RiotApi::MatchHistory < RiotApi

  # parameters
  #   championIds: Comma-separated list of champion IDs
  #   rankedQueues: ["RANKED_SOLO_5x5","RANKED_TEAM_3x3","RANKED_TEAM_5x5"]
  #   beginIndex: Integer
  #   endIndex: Integer
  def self.get_summoner_history_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {championIds: false, rankedQueues: false, beginIndex: false, endIndex: false}
    url = "#{base_matchhistory_url(args[:region])}/#{args[:id]}"
    get_api_response(url, params)
  end

  protected
  def self.base_matchhistory_url region
    "#{base_url region}/v2.2/matchhistory"
  end

end