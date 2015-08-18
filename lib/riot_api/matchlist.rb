class RiotApi::Matchlist < RiotApi

  # parameters
  #   championIds: Comma-separated list of champion IDs
  #   rankedQueues: ["RANKED_SOLO_5x5","RANKED_TEAM_3x3","RANKED_TEAM_5x5"]
  #   seasons: ["PRESEASON2014", "SEASON2014", "PRESEASON2015","SEASON2015"]
  #   beginTime: The begin time to use for fetching games specified as epoch milliseconds.
  #   endTime: The end time to use for fetching games specified as epoch milliseconds.
  #   beginIndex: The begin index to use for fetching games.
  #   endIndex: The end index to use for fetching games.
def self.get_match_list_by_summoner_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {championIds: false, rankedQueues: false, beginTime: false, endTime: false, beginIndex: false, endIndex: false}
    url = "#{base_matchlist_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end

  protected
  def self.base_matchlist_url region
    "#{base_url region}/v2.2/matchhistory"
  end

end