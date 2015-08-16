class RiotApi::Stats < RiotApi
  def self.get_ranked args
    check_args args, [:id, :region]
    url = "#{base_stats_url(args[:region])}/#{args[:id]}/ranked"
    get_api_response(url)
  end

  def self.get_summary args
    check_args args, [:id, :region]
    url = "#{base_stats_url(args[:region])}/#{args[:id]}/summary"
    get_api_response(url)
  end



  protected
  def self.base_stats_url region
    "#{base_url region}/v1.3/stats/by-summoner"
  end

end