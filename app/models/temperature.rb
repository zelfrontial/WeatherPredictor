class Temperature < ActiveRecord::Base
	belongs_to :SingleReading
	belongs_to :TemperaturePrediction
end
