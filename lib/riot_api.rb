class RiotApi
  protected
  def self.base_url region
    "https://#{region}.#{BASE_URL}/#{region}"
  end

  def self.format_response res
    JSON.parse(res.body)
  end

  def self.get_api_response base_url, params = []
    url_with_params = "#{base_url}?api_key=#{API_KEY}"
    params.each do |k, v|
      url_with_params += "&#{k}=#{v}"
    end
    url = URI.parse(url_with_params)
    req = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    format_response(http.request(req))
  end

  def self.check_args provided, expected
    expected.each do |k|
      raise ArgumentError, "Missing key : #{k}. Expected : #{expected.to_s}" unless provided.include? k
    end
  end

  def self.check_params provided, params
    provided.each do |k, v|
      raise ArgumentError, "Key not allowed : #{k}. Allowed : #{params.to_s}" unless params.keys.include? k
    end
    required = params.select{|k, v| v == true}
    required.keys.each do |k|
      raise ArgumentError, "Missing parameter : #{k}. Required : #{required.to_s}" unless provided.keys.include? k
    end
  end
end