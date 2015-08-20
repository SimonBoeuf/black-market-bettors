class RiotApi
  def self.base_url region
    "https://#{region}.#{BASE_URL}/#{region}"
  end

  def self.format_response res
    JSON.parse(res.body)
  end

  def self.get_api_response base_url, params = {}
    url_with_params = "#{base_url}?api_key=#{API_KEY}"
    params.each do |k, v|
      url_with_params += "&#{k}=#{v}"
    end
    url = URI.parse(url_with_params)
    req = Net::HTTP::Get.new(url.request_uri)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    queue_api_request TIME_OFFSET
    format_response(http.request(req))
  end

  def self.get_static_data_api_response base_url, params = {}
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
      raise ArgumentError, "Key not allowed : #{k}. Allowed : #{params.keys.to_s}" unless params.keys.include? k
    end
    required = params.select{|k, v| v == true}
    required.keys.each do |k|
      raise ArgumentError, "Missing parameter : #{k}. Required : #{required.keys.to_s}" unless provided.keys.include? k
    end
  end
  def self.queue_api_request offset
    @last_request ||= Time.now
    while (Time.now < (@last_request + offset)) do end
    @last_request = Time.now
    return nil
  end
  private_class_method :base_url, :format_response, :get_api_response, :check_args, :check_params
end