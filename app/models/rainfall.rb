class Rainfall < ActiveRecord::Base
	belongs_to :SingleReading
	belongs_to :RainfallPrediction
end
