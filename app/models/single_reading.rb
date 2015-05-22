class SingleReading < ActiveRecord::Base
	belongs_to :reading
	belongs_to :station
end
	