class Postcode < ActiveRecord::Base
	has_one :geolocation
end
