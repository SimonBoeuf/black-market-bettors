class RiotApi::MatchHistory < RiotApi

  def self.get_summoner_history_by_id args
    check_args args, [:id, :region]
    url = "#{base_matchhistory_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end

  protected
  def self.base_matchhistory_url region
    "#{base_url region}/v2.2/matchhistory"
  end

end