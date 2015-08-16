class RiotApi::Champion < RiotApi
  def self.get_all_champs args
    check_args args, [:region]
    url = "#{base_champion_url(args[:region])}"
    get_api_response(url)
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