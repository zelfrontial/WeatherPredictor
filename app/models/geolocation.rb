class Geolocation < ActiveRecord::Base
	has_one :station
	has_one :postcode

end
