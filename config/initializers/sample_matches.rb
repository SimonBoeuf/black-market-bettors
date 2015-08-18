SAMPLE_MATCHES = Hash.new
Dir.entries("config/matches").each do |region|
  SAMPLE_MATCHES[region[0, region.index(".json")]] = JSON.parse(File.read("config/matches/#{region}")) if region.index(".json")
end