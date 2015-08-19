RIOT_API_CONF = YAML.load_file(Rails.root.join("config/riot_api.yml"))[Rails.env]
API_KEY = RIOT_API_CONF['api_key']
BASE_URL = RIOT_API_CONF['base_url']
TIME_OFFSET = RIOT_API_CONF['time_offset']