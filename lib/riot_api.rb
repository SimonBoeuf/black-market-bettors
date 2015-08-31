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
    loop do
      ap "Trying again : #{@res.code}, #{@res.to_hash.inspect}" if @res && @res.code != "200"
      queue_api_request TIME_OFFSET
      @res = http.request(req)
      return nil if @res.code == '500'
      break if (http.request(req).code == '200')
    end
    format_response(@res)
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
    res = http.request(req)
    res.code == "200" ? format_response(res) : nil
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