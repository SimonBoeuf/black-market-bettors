class RiotApi::StaticData < RiotApi
  def self.get_champion_list args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/champion"
    get_api_response(url)
  end

  def self.get_champion_by_id args
    check_args args, [:id, :region]
    url = "#{base_static_data_url(args[:region])}/champion/#{args[:id]}"
    get_api_response(url)
  end

  def self.get_item_list args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/item"
    get_api_response(url)
  end

  def self.get_item_by_id args
    check_args args, [:id, :region]
    url = "#{base_static_data_url(args[:region])}/item/#{args[:id]}"
    get_api_response(url)
  end

  def self.get_language_strings args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/language-strings"
    get_api_response(url)
  end

  def self.get_languages args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/languages"
    get_api_response(url)
  end

  def self.get_map args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/map"
    get_api_response(url)
  end

  def self.get_mastery_list args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/mastery"
    get_api_response(url)
  end

  def self.get_mastery_by_id args
    check_args args, [:id, :region]
    url = "#{base_static_data_url(args[:region])}/mastery/#{args[:id]}"
    get_api_response(url)
  end

  def self.get_realm args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/realm"
    get_api_response(url)
  end

  def self.get_rune_list args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/rune"
    get_api_response(url)
  end

  def self.get_rune_by_id args
    check_args args, [:id, :region]
    url = "#{base_static_data_url(args[:region])}/rune/#{args[:id]}"
    get_api_response(url)
  end

  def self.get_summoner_spell_list args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/summoner-spell"
    get_api_response(url)
  end

  def self.get_summoner_spell_by_id args
    check_args args, [:id, :region]
    url = "#{base_static_data_url(args[:region])}/summoner-spell/#{args[:id]}"
    get_api_response(url)
  end


  def self.get_versions_lists args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/versions"
    get_api_response(url)
  end

  protected
  def self.base_static_data_url region
    "https://global.#{BASE_URL}/static-data/#{region}/v1.2"
  end

end