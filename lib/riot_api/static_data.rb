class RiotApi::Static_Data < RiotApi

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   dataById: Boolean
  #   champData: ["all", "allytips", "altimages", "blurb", "ennemytips", "image", "info", "lore", "partype", "passive", "recommended", "skins", "spells", "stats", "tags"]
  def self.get_champion_list args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false, dataById: false, champData: false}
    url = "#{base_static_data_url(args[:region])}/champion"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   champData: ["all", "allytips", "altimages", "blurb", "ennemytips", "image", "info", "lore", "partype", "passive", "recommended", "skins", "spells", "stats", "tags"]
  def self.get_champion_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {locale: false, version: false, champData: false}
    url = "#{base_static_data_url(args[:region])}/champion/#{args[:id]}"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   itemListData: ["all", "colloq", "consumeOnFull", "consumed", "depth", "from", "gold", "groups", "hideFromAll", "image", "inStore", "into", "maps", "requiredChampion", "sanitizedDescription", "specialRecipe", "stacks", "stats", "tags", "tree"]
  def self.get_item_list args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false, itemListData: false}
    url = "#{base_static_data_url(args[:region])}/item"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   itemData: ["all", "colloq", "consumeOnFull", "consumed", "depth", "from", "gold", "groups", "hideFromAll", "image", "inStore", "into", "maps", "requiredChampion", "sanitizedDescription", "specialRecipe", "stacks", "stats", "tags", "tree"]
  def self.get_item_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {locale: false, version: false, itemData: false}
    url = "#{base_static_data_url(args[:region])}/item/#{args[:id]}"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  def self.get_language_strings args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false}
    url = "#{base_static_data_url(args[:region])}/language-strings"
    get_api_response(url, params)
  end

  def self.get_languages args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/languages"
    get_api_response(url)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  def self.get_map args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false}
    url = "#{base_static_data_url(args[:region])}/map"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   masteryListData: ["all", "image", "masteryTree", "prereq", "ranks", "sanitizedDescription", "tree"]
  def self.get_mastery_list args, params
    check_args args, [:region]
    check_params params, {locale: false, version: false, masteryListData: false}
    url = "#{base_static_data_url(args[:region])}/mastery"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   masteryData: ["all", "image", "masteryTree", "prereq", "ranks", "sanitizedDescription", "tree"]
  def self.get_mastery_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {locale: false, version: false, masteryData: false}
    url = "#{base_static_data_url(args[:region])}/mastery/#{args[:id]}"
    get_api_response(url, params)
  end

  def self.get_realm args
    check_args args, [:region]
    url = "#{base_static_data_url(args[:region])}/realm"
    get_api_response(url)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   runeListData: ["all", "basic", "colloq", "consumeOnFull", "consumed", "depth", "from", "gold", "hideFromAll", "image", "inStore", "into", "maps", "requiredChampion", "sanitizedDescription", "specialRecipe", "stacks", "stats", "tags"]
  def self.get_rune_list args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false, runeListData: false}
    url = "#{base_static_data_url(args[:region])}/rune"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   runeData: ["all", "basic", "colloq", "consumeOnFull", "consumed", "depth", "from", "gold", "hideFromAll", "image", "inStore", "into", "maps", "requiredChampion", "sanitizedDescription", "specialRecipe", "stacks", "stats", "tags"]
  def self.get_rune_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {locale: false, version: false, runeData: false}
    url = "#{base_static_data_url(args[:region])}/rune/#{args[:id]}"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   dataById: Boolean
  #   spellData: ["all", "cooldown", "cooldownBurn", "cost", "costBurn", "costType", "effect", "effectBurn", "image", "key", "leveltips", "maxrank", "modes", "range", "rangeBurn", "resource", "sanitizedDescription", "sanitizedToolTip", "tooltip", "vars"]
  def self.get_summoner_spell_list args, params = {}
    check_args args, [:region]
    check_params params, {locale: false, version: false, dataById: false, spellData: false}
    url = "#{base_static_data_url(args[:region])}/summoner-spell"
    get_api_response(url, params)
  end

  # parameters
  #   locale:["en_US,es_ES,...]"
  #   version: "DataDragon version"
  #   spellData: ["all", "cooldown", "cooldownBurn", "cost", "costBurn", "costType", "effect", "effectBurn", "image", "key", "leveltips", "maxrank", "modes", "range", "rangeBurn", "resource", "sanitizedDescription", "sanitizedToolTip", "tooltip", "vars"]
  def self.get_summoner_spell_by_id args, params = {}
    check_args args, [:id, :region]
    check_params params, {locale: false, version: false, spellData: false}
    url = "#{base_static_data_url(args[:region])}/summoner-spell/#{args[:id]}"
    get_api_response(url, params)
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