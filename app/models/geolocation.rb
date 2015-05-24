class Geolocation < ActiveRecord::Base
	belongs_to :station
	belongs_to :postcode

end
