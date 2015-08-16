class RiotApi
  protected
  def self.base_url region
    "https://#{region}.#{BASE_URL}/#{region}"
  end

  def self.format_response res
    JSON.parse(res.body)
  end

  def self.get_api_response base_url
    url = URI.parse("#{base_url}?api_key=#{API_KEY}")
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
end