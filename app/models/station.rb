class Station < ActiveRecord::Base
	has_one :geolocation
end
