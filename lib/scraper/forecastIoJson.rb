require 'open-uri'
require 'json'
require 'date'

API_KEY = '9ec4600f0f75d514758d614600522388'
BASE_URL = 'https://api.forecast.io/forecast'

def current_date(f)
	unix_date = f["currently"]["time"]
	date = DateTime.strptime("#{unix_date}",'%s')
	return date.strftime("%Y-%m-%d")
end

def current_time(f)
	unix_time = f["currently"]["time"]
	time = DateTime.strptime("#{unix_time}",'%s')
	return time.strftime("%I:%M %p")
end

#API returns fahrenheit ,we convert it to celcius
def current_temperature(f)
	return to_celcius(f["currently"]["temperature"])
end

# Fahrenheit to Celcius
def to_celcius(fahrenheit)
	return (fahrenheit-32)/1.8
end

def current_dew_point(f)
	return to_celcius(f["currently"]["dewPoint"])
end

#Return bearings instead of degree
def current_wind_direction(f)
	return degToCompass(Integer(f["currently"]["windBearing"]))
end

#Adepted from http://stackoverflow.com/questions/7490660/converting-wind-direction-in-angles-to-text-words
def degToCompass(num)
    val=Integer((num/22.5)+0.5)
    arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    return arr[(val % 16)]
end

#windSpeed: Meters per second.
def current_wind_speed(f)
	return f["currently"]["windSpeed"]
end

#Convert to rainfall since 9 am
def current_rainfall(f)

	rainfall_per_hour = f["currently"]["precipIntensity"]

	time_since_9 = time_since_9_am(current_time(f))
	return (rainfall_per_hour * time_since_9)
end

def time_since_9_am(time)
	time = DateTime.strptime(time,"%I:%M %p")
	nine_am = "09:00 AM"
	nine_am =  DateTime.strptime(nine_am,"%I:%M %p")
	time_elapsed = time - nine_am
	time_elapsed =  time_elapsed
	hour_passed = Float(time_elapsed*24)
	if (hour_passed < 0 )
		return hour_passed + 24
	else
		return hour_passed
	end
end

# Persist Reading to database
def save_reading()
	Station.all.each do |x|
		station_id = x.station_id
		lat = x.lat
		long = x.long
		lat_long = "#{lat},#{long}"
		forecast = JSON.parse(open("#{BASE_URL}/#{API_KEY}/#{lat_long}").read)
		r = WeatherReading.new
		r.build_reading(station_id,lat,long,current_date(forecast),current_time(forecast),current_temperature(forecast),current_dew_point(forecast),
			current_wind_direction(forecast),current_wind_speed(forecast),current_rainfall(forecast),"forecast.io")
		r.save
	end

end
save_reading()