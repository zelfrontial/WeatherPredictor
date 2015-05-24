class Station < ActiveRecord::Base
	has_one :geolocation

	attr_reader :stationID
	attr_reader :name
	attr_reader :geolocation
	attr_reader :created_at
	attr_reader :modified_at

	def initialise stationID name geolocation created_at modified_at
		@stationID = stationID
		@name = name
		@geolocation = geolocation
		@created_at = created_at
		@modified_at = modified_at
	end
end




