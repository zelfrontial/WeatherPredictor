class LocationController < ApplicationController
	def getAllStation
		@stations = Station.all
		@currentTime = Date.today.to_s
		respond_to do |format|
	      format.html
	      format.json
	  	end
	end
	
end
