class Postcode < ActiveRecord::Base
	has_one :geolocation


	attr_reader :Postcode
	attr_reader :geolocation

	def initialise Postcode geolocation
		@Postcode = Postcode
		@geolocation = geolocation
	end

	def getReleventStation p
	end

	
end
