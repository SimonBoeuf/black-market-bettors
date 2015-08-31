GAME_SPEED = 5
File.exists?(Rails.root.join("config/riot_api.yml")) ? RIOT_API_CONF = YAML.load_file(Rails.root.join("config/riot_api.yml"))[Rails.env] : RIOT_API_CONF = {}
API_KEY = RIOT_API_CONF['api_key'] || ENV['API_KEY']
BASE_URL = RIOT_API_CONF['base_url'] || ENV['BASE_URL']
TIME_OFFSET = RIOT_API_CONF['time_offset'] || ENV['TIME_OFFSET'].to_i