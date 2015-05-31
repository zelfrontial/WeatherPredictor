class Station < ActiveRecord::Base
	belongs_to :geolocation
	has_many :single_readings
end
