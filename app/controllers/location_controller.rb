class LocationController < ApplicationController
	def getAllStation
		@stations = Station.all
		@geolocations = Geolocation.joins(:station)
	end
	def show
	end
end
