class Station < ActiveRecord::Base
	has_many :single_readings
end
