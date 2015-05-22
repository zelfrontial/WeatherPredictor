class Reading < ActiveRecord::Base
	has_many :single_readings
	has_one :source
end
