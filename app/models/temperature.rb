class Temperature < ActiveRecord::Base
	has_one :single_reading
end
