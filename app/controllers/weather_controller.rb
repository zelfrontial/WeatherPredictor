class WeatherController < ApplicationController
  def data

	@weather_readings = WeatherReading.all
  	
  end
end

