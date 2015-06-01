class SingleReading < ActiveRecord::Base
	belongs_to :reading
	belongs_to :station
	belongs_to :rainfall
	belongs_to :temperature
	belongs_to :dew_point
	belongs_to :wind
end
