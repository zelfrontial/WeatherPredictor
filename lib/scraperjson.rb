require 'nokogiri'
require 'open-uri'
require 'json'

windDirStr = [ "N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW" ]
stations = Station.all

# Record new reading session
r = Reading.new
if source = Source.where(:name => "forecast.io").first
	r.source_id = source.id
end
r.save

API_KEY = '63b06ee6862b822e3392bab457daf4ab'
BASE_URL = 'https://api.forecast.io/forecast'

# Record readings for each station
stations.each do |station|
	# Define the URL
	lat_long = "#{station.latitude},#{station.longitude}"

	# Make sure you down forget the .read on the open file.
	forecast = JSON.parse(open("#{BASE_URL}/#{API_KEY}/#{lat_long}?units=ca").read)

	# forecast = JSON.parse(open("test.json").read)
	sr = SingleReading.new
	sr.reading_id = r.id
	sr.time = Time.strptime(forecast["currently"]["time"].to_s, '%s').in_time_zone("Melbourne")
	sr.station_id = station.id
	hours_since_9am = (sr.time - Time.strptime("09:00am", '%I:%M%P').in_time_zone("Melbourne")) / 3600
	if hours_since_9am < 0
		hours_since_9am += 24
	end
	sr.rainfall = forecast["currently"]["precipIntensity"].to_f * hours_since_9am
	sr.temperature = forecast["currently"]["temperature"].to_f
	sr.dewPoint = forecast["currently"]["dewPoint"].to_f
	sr.windSpeed = forecast["currently"]["windSpeed"].to_f
	if sr.windSpeed == 0
		sr.windDirection = 'CALM'
	else
		sr.windDirection = windDirStr[((((forecast["currently"]["windBearing"].to_f / 360.0) * 16) + 0.5) % 16)]
	end
	sr.save
end