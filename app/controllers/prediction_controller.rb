class PredictionController < ApplicationController
	def getPostcodePrediction
		@postcode = params[:postcode].to_i
		@period = params[:period].to_i
		@station = Postcode.where(:postcode => @postcode).first.getRelevantStation
		@single_readings = SingleReading.where(:station_id => @station.id).last(50)
		temperature_array = Array.new
		rainfall_array = Array.new
		wind_speed_array = Array.new
		wind_direction_array = Array.new
		time_array = Array.new
		@single_readings.each do |sr|
			temperature_array.push(sr.temperature.temperature)
			rainfall_array.push(sr.rainfall.rainfall)
			wind_speed_array.push(sr.wind.windSpeed)
			wind_direction_array.push(sr.wind.windDirection)
			time_array.push((sr.created_at - @single_readings.first.created_at).to_i.abs / 60)
		end
		@time_now = (Time.now - @single_readings.first.created_at).to_i.abs / 60
		@temperature_prediction = TemperaturePrediction.new.calculatePrediction time_array, temperature_array, @time_now
		@rainfall_prediction = RainfallPrediction.new.calculatePrediction time_array, rainfall_array, @time_now
		@wind_prediction = WindPrediction.new.calculatePrediction time_array, wind_speed_array, wind_direction_array, @time_now
	end

	def getGeolocationPrediction
		@geolocation = Geolocation.new
		@geolocation.latitude = params[:lat].to_f
		@geolocation.longitude = params[:long].to_f
		@period = params[:period].to_i
		@station = @geolocation.getRelevantStation
		@single_readings = SingleReading.where(:station_id => @station.id).last(50)
		temperature_array = Array.new
		rainfall_array = Array.new
		wind_speed_array = Array.new
		wind_direction_array = Array.new
		time_array = Array.new
		@single_readings.each do |sr|
			temperature_array.push(sr.temperature.temperature)
			rainfall_array.push(sr.rainfall.rainfall)
			wind_speed_array.push(sr.wind.windSpeed)
			wind_direction_array.push(sr.wind.windDirection)
			time_array.push((sr.created_at - @single_readings.first.created_at).to_i.abs / 60)
		end
		@time_now = (Time.now - @single_readings.first.created_at).to_i.abs / 60
		@temperature_prediction = TemperaturePrediction.new.calculatePrediction time_array, temperature_array, @time_now
		@rainfall_prediction = RainfallPrediction.new.calculatePrediction time_array, rainfall_array, @time_now
		@wind_prediction = WindPrediction.new.calculatePrediction time_array, wind_speed_array, wind_direction_array, @time_now
	end
end
