class WeatherReading < ActiveRecord::Base
	def build_reading(station_id,lat,long,date,time,temperature,dew_point,
		wind_direction,wind_speed,rainfall,source)
		
		self.station_id = station_id
		self.lat = lat
		self.long = long
		self.date = date
		self.time = time
		self.temperature = temperature
		self.dew_point = dew_point
		self.wind_direction = wind_direction
		self.wind_speed = wind_speed
		self.rainfall = rainfall
		self.source = source
		#saving done in parse maybe change it to here
	end
end
