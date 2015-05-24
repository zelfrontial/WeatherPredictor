class Geolocation < ActiveRecord::Base
	belongs_to :station
	belongs_to :postcode

 	attr_reader :latitude
 	attr_reader :longitude

 	def initialise latitude longitude
 		@latitude = latitude
 		@longitude = longitude
 	end

 	def getDistance lat long  
 		Math.sqrt(lat(long).map {|x| (x[1] - x[0])**2}.reduce(:+))
 	end

 	def getRelevantStation lat long
 		location_info = request.getRelevantStation
 		@locations = Location.near([location_info.latitude, location_info.longitude])
 	end



end
