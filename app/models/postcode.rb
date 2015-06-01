class Postcode < ActiveRecord::Base
	belongs_to :geolocation

	def getRelevantStation
		Geolocation.where(:id => self.geolocation_id).first.getRelevantStation
	end
end
