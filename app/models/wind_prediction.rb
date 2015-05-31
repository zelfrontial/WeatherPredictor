class WindPrediction
	def calculatePrediction timeArray, speedArray, directionArray
		require_relative 'regression.rb'

		# convert from wind direction to wind bearing
		windDirStr = [ "N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "SW", "WNW", "NW", "NNW" ]
		bearingArray = Array.new
		directionArray.each do |e|
			bearingArray.push(windDirStr.index(e) * 360 / 16)
		end

		# calculate using 4 regressions
		linear_speed = LinearRegression.new timeArray, speedArray
		linear_speed.process_regression
		linear_direction = LinearRegression.new timeArray, bearingArray
		linear_direction.process_regression
		polynomial_speed = PolynomialRegression.new timeArray, speedArray
		polynomial_speed.process_regression
		polynomial_direction = PolynomialRegression.new timeArray, bearingArray
		polynomial_direction.process_regression
		begin
			logarithmic_speed = LogarithmicRegression.new timeArray, speedArray
			logarithmic_speed.process_regression
		rescue Math::DomainError
			logarithmic_speed = nil
		end
		begin
			logarithmic_direction = LogarithmicRegression.new timeArray, bearingArray
			logarithmic_direction.process_regression
		rescue Math::DomainError
			logarithmic_direction = nil
		end
		begin
			exponential_speed = ExponentialRegression.new timeArray, speedArray
			exponential_speed.process_regression
		rescue Math::DomainError
			exponential_speed = nil
		end
		begin
			exponential_direction = ExponentialRegression.new timeArray, bearingArray
			exponential_direction.process_regression
		rescue Math::DomainError
			exponential_direction = nil
		end

		# find the best fit between those 4
		bestfit_speed = linear_speed
		[polynomial_speed, logarithmic_speed, exponential_speed].each { |reg| bestfit_speed = reg if reg.mse < bestfit_speed.mse unless reg == nil }
		bestfit_direction = linear_direction
		[polynomial_direction, logarithmic_direction, exponential_direction].each { |reg| bestfit_direction = reg if reg.mse < bestfit_direction.mse unless reg == nil }

		windspeed_prediction = Array.new
		windbearing_prediction = Array.new
		wind_prediction = Array.new

		## calculate the speed prediction
		if bestfit_speed == linear_speed || bestfit_speed == polynomial_speed
        	(0..18).each do |x|
            	y = 0.0
            	(0..bestfit_speed.degree).each { |i| y += bestfit_speed.coefficients[i] * ((timeArray.last + (x*10))**i) }
            	windspeed_prediction.push(y)
        	end
        end

        elsif bestfit_speed == logarithmic_speed
			(0..18).each do |x|
				y = bestfit_speed.coefficients[0] + (bestfit_speed.coefficients[1] * Math.log((timeArray.last + (x*10))))
				windspeed_prediction.push(y)
			end
        end

        elsif bestfit_speed == exponential_speed
			(0..18).each do |x|
				y = bestfit_speed.coefficients[0] * (Math::E**(bestfit_speed.coefficients[1] * (timeArray.last + (x*10))))
				windspeed_prediction.push(y)
			end
        end

        ## calculate the wind direction prediction
        if bestfit_direction == linear_direction || bestfit_direction == polynomial_direction
        	(0..18).each do |x|
            	y = 0.0
            	(0..bestfit_direction.degree).each { |i| y += bestfit_direction.coefficients[i] * ((timeArray.last + (x*10))**i) }
            	windbearing_prediction.push(y)
        	end
        end

        elsif bestfit_direction == logarithmic_direction
			(0..18).each do |x|
				y = bestfit_direction.coefficients[0] + (bestfit_direction.coefficients[1] * Math.log((timeArray.last + (x*10))))
				windbearing_prediction.push(y)
			end
        end

        elsif bestfit_direction == exponential_direction
			(0..18).each do |x|
				y = bestfit_direction.coefficients[0] * (Math::E**(bestfit_direction.coefficients[1] * (timeArray.last + (x*10))))
				windbearing_prediction.push(y)
			end
        end

        ## create the wind object
        (0..18).each do |x|
        	w = Wind.new
        	w.windSpeed = windspeed_prediction[x]
        	wind_bearing = windbearing_prediction[x]
        	# if speed is negative, reverse the direction
        	if w.windSpeed < 0
            	w.windSpeed *= -1
            	wind_bearing += 180
            end
        	w.windDirection = windDirStr[((((wind_bearing / 360.0) * 16) + 0.5) % 16)]
        	wind_prediction.push(w)
        end

        [wind_prediction, bestfit.mse]
	end
end
