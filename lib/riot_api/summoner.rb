class RiotApi::Summoner < RiotApi
  def self.get_by_name args
    check_args args, [:name, :region]
    url = "#{base_summoner_url(args[:region])}/by-name/#{args[:name]}"
    get_api_response(url)
  end

  def self.get_by_id args
    check_args args, [:id, :region]
    url = "#{base_summoner_url(args[:region])}/#{args[:id]}"
    get_api_response(url)
  end

  def self.get_masteries args
    check_args args, [:id, :region]
    url = "#{base_summoner_url(args[:region])}/#{args[:id]}/masteries"
    get_api_response(url)
  end

  def self.get_names args
    check_args args, [:ids, :region]
    url = "#{base_summoner_url(args[:region])}/#{args[:ids]}/name"
    get_api_response(url)
  end

  def self.get_runes args
    check_args args, [:id, :region]
    url = "#{base_summoner_url(args[:region])}/#{args[:id]}/runes"
    get_api_response(url)
  end

  protected
  def self.base_summoner_url region
    "#{base_url region}/v1.4/summoner"
  end

end