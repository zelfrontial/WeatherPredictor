class ReadingController < ApplicationController
	def getPostcodeReading
		@date = Date.strptime(params[:date], "%d-%m-%Y")
		@station = Postcode.where(:postcode => params[:postcode]).first.getRelevantStation
		@single_readings = SingleReading.where(:station_id => @station.id, :created_at => (@date.beginning_of_day..@date.end_of_day))
		if @single_readings.length > 0
			if @single_readings.length > 1 && @single_readings.last.rainfall.rainfall - @single_readings.last(2).first.rainfall.rainfall > 0
				@condition = "Raining"
			elsif @single_readings.last.wind.windSpeed > 18
				@condition = "Windy"
			elsif @single_readings.last.temperature.temperature > 18
				@condition = "Sunny"
			else
				@condition = "Cloudy"
			end
		end

	    respond_to do |format|
	      format.html
	      format.json
	  	end		
	end

	def getLocationReading
		@date = Date.strptime(params[:date], "%d-%m-%Y")
		@station = Station.where(:stationID => params[:location_id]).first
		@single_readings = SingleReading.where(:station_id => @station.id, :created_at => (@date.beginning_of_day..@date.end_of_day))
		if @single_readings.length > 0
			if @single_readings.length > 1 && @single_readings.last.rainfall.rainfall - @single_readings.last(2).first.rainfall.rainfall > 0
				@condition = "Raining"
			elsif @single_readings.last.wind.windSpeed > 18
				@condition = "Windy"
			elsif @single_readings.last.temperature.temperature > 18
				@condition = "Sunny"
			else
				@condition = "Cloudy"
			end
		end

		respond_to do |format|
	      format.html
	      format.json
	  	end		
	end
end
