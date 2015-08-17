class RiotApi::Champion < RiotApi

  # parameters
  #   freeToPlay:Boolean
  def self.get_all_champs args, params = {}
    check_args args, [:region]
    check_params(params, {freeToPlay: false})
    url = "#{base_champion_url(args[:region])}"
    get_api_response(url, params)
  end

  def self.get_by_id args
    check_args args, [:id, :region]
    url = "#{base_champion_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end



  protected
  def self.base_champion_url region
    "#{base_url region}/v1.2/champion"
  end

end