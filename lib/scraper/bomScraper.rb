require 'nokogiri'
require 'open-uri'
require 'date'
URL = 'http://www.bom.gov.au/vic/observations/melbourne.shtml'

def current_time(t)

	l_string = t.css('p')[1].text.split()
	time = l_string[2] + " "
	time += l_string[3]
	time = DateTime.strptime("#{time}",'%l:%M %P')
	time =  time.strftime("%I:%M %p")
	if time == "-"
		return nil
	else 
		return time
	end
end

def current_date(t)
	l_string = t.css('p')[1].text.split()
	date = l_string[6] + " "
	date += l_string[7] + " "
	date += l_string[8]
	date = DateTime.strptime("#{date}",'%e %B %Y')
	date = date.strftime("%Y-%m-%d")
	if date == "-"
		return nil
	else 
		return date
	end	
end

def current_temperature(t,location)
	tag = 'obs-apptemp '
	tag += location
	tag = t.css("td[headers = '#{tag}']").text
	if tag == "-"
		return nil
	else 
		return tag
	end
end

def current_temperature(t,location)
	tag = 'obs-apptemp '
	tag += location
	tag = t.css("td[headers = '#{tag}']").text
	if tag == "-"
		return nil
	else 
		return tag
	end	
end

def current_rainfall(t,location)
	tag = 'obs-rainsince9am '
	tag += location
	tag =  t.css("td[headers = '#{tag}']").text
	if tag == "-" || tag == "Trace"
		return nil
	else 
		return tag
	end
end

def current_dew_point(t,location)
	tag = 'obs-dewpoint '
	tag += location
	tag = t.css("td[headers = '#{tag}']").text
	if tag == "-"
		return nil
	else 
		return tag
	end
end

def current_wind_direction(t,location)
	tag = 'obs-wind obs-wind-dir '
	tag += location
	tag = t.css("td[headers = '#{tag}']").text
	if tag == "CALM"
		return nil
	else
		return tag
	end
end

#convert to km per hour
def current_wind_speed(t,location)
	tag = 'obs-wind obs-wind-spd-kph '
	tag += location
	tag = t.css("td[headers = '#{tag}']").text
	if tag == "-"
		return nil
	else 
		return mph_to_kmh(tag)
	end
end

def mph_to_kmh(speed)
	return Float(speed)*1.609344
end

#Persist Reading to database
def save_reading()
	
	doc = Nokogiri::HTML(open(URL))
	table = doc.at('tbody')
	Station.all.each do |x|
		station_id = "obs-station-#{x.station_id}"
		lat = x.lat
		long = x.long
		r = WeatherReading.new
		r.build_reading(x.station_id,lat,long,current_date(doc),current_time(doc),current_temperature(table,station_id),current_dew_point(table,station_id),
		 	current_wind_direction(table,station_id),current_wind_speed(table,station_id),current_rainfall(table,station_id),"BOM")

		r.save

	end

end

save_reading()
#puts current_temperature(table,'obs-station-melbourne-olympic-park')
