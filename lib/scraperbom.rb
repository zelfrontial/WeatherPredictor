# Define the URL we are opening
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'
require 'nokogiri'
require 'open-uri'

# Open the HTML link with Nokogiri
doc = Nokogiri::HTML(open(URL))

# Record new reading session
r = Reading.new
if source = Source.where(:name => "Bureau of Meteorology Australia").first
	r.source_id = source.id
end
r.save

# Parse the table
station_list =  doc.css('tbody tr.rowleftcolumn th')
time_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-datetime]')
rainfall_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-rainsince9am]')
temp_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-temp]')
dewpoint_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-dewpoint]')
winddirection_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-wind-dir]')
windspeed_list =  doc.css('tbody tr.rowleftcolumn td[headers*=obs-wind-spd-kph]')

# Store it
(0..station_list.length-1).each do |row|
	sr = SingleReading.new
	sr.reading_id = r.id
	if station = Station.where(:name => station_list[row].content).first
		sr.station_id = station.id
	end
	time = Time.strptime(time_list[row].content, "%e/%I:%M%P").in_time_zone("Melbourne")


	# single_reading = SingleReading.where(:time => time,:station_id => station.id)
	# # if there is duplicate then break
	# if single_reading
	# 	break
	# end



	sr.time = time



	rain = ((rainfall_list[row].content.eql? '-') ? nil : rainfall_list[row].content.to_f)
	rainfall = Rainfall.new(rainfall: rain)	
	rainfall.save

	tmp = ((temp_list[row].content.eql? '-') ? nil : temp_list[row].content.to_f)
	temperature = Temperature.new(temperature: tmp)
	temperature.save

	dew_p = ((dewpoint_list[row].content.eql? '-') ? nil : dewpoint_list[row].content.to_f)
	dewPoint = DewPoint.new(dewPoint: dew_p)
	dewPoint.save


	w_speed = ((windspeed_list[row].content.eql? '-') ? nil : windspeed_list[row].content.to_f)
	w_dir = ((winddirection_list[row].content.eql? '-') ? nil : winddirection_list[row].content)
	wind = Wind.new(windDirection: w_dir,windSpeed: w_speed)
	wind.save

	sr.dew_point_id = dewPoint.id
	sr.rainfall_id = rainfall.id
	sr.temperature_id = temperature.id
	sr.wind_id = wind.id

	sr.save
end
