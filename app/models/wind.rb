class Wind < ActiveRecord::Base
	belongs_to :SingleReading
	belongs_to :WindPrediction
end
