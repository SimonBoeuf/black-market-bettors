class RiotApi::Match < RiotApi

  def self.get_by_id args
    check_args args, [:id, :region]
    url = "#{base_match_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end

  protected
  def self.base_match_url region
    "#{base_url region}/v2.2/match"
  end

end