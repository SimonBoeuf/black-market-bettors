class RiotApi::MatchList < RiotApi

  def self.get_match_list_by_summoner_id args
    check_args args, [:id, :region]
    url = "#{base_matchlist_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end

  protected
  def self.base_matchlist_url region
    "#{base_url region}/v2.2/matchhistory"
  end

end