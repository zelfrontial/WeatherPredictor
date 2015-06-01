class Geolocation < ActiveRecord::Base
	has_one :station
	has_one :postcode

	def getRelevantStation
		stations = Station.all
		closest_station = stations.first
		closest_distance = ((self.latitude - closest_station.geolocation.latitude)**2 + (self.longitude - closest_station.geolocation.longitude)**2)**0.5
		stations.each do |s|
			current_distance = ((self.latitude - s.geolocation.latitude)**2 + (self.longitude - s.geolocation.longitude)**2)**0.5
			if current_distance < closest_distance
				closest_station = s
				closest_distance = current_distance
			end
		end
		return closest_station
	end
end
