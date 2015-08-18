class RiotApi::Match < RiotApi
  
  def self.get_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {includeTimeline: false}
    url = "#{base_match_url(args[:region])}/#{args[:id]}"
    get_api_response(url, params)
  end


  def self.base_match_url region
    "#{base_url region}/v2.2/match"
  end

  private_class_method :base_match_url
end