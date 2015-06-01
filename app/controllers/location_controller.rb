class LocationController < ApplicationController
	def getAllStation
		@stations = Station.all
	end
end
