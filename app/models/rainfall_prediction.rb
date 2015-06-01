class RainfallPrediction
	def calculatePrediction timeArray, valueArray, timeNow
		require_relative 'regression.rb'

		# calculate using 4 regressions
		linear = LinearRegression.new timeArray, valueArray
		linear.process_regression
		polynomial = PolynomialRegression.new timeArray, valueArray
		polynomial.process_regression
		begin
			logarithmic = LogarithmicRegression.new timeArray, valueArray
			logarithmic.process_regression
		rescue Math::DomainError
			logarithmic = nil
		end
		begin
			exponential = ExponentialRegression.new timeArray, valueArray
			exponential.process_regression
		rescue Math::DomainError
			exponential = nil
		end

		# calculate the rainfall prediction and return the rainfall objects
		bestfit = linear
		[polynomial, logarithmic, exponential].each { |reg| bestfit = reg if reg.mse < bestfit.mse unless reg == nil }

		rainfall_prediction = Array.new
		if bestfit == linear || bestfit == polynomial
        	(0..18).each do |x|
            	r = Rainfall.new
            	y = 0.0
            	(0..bestfit.degree).each { |i| y += bestfit.coefficients[i] * ((timeNow + (x*10))**i) }
            	r.rainfall = y
            	rainfall_prediction.push(r)
        	end

        elsif bestfit == logarithmic
			(0..18).each do |x|
				r = Rainfall.new
				r.rainfall = bestfit.coefficients[0] + (bestfit.coefficients[1] * Math.log((timeNow + (x*10))))
				rainfall_prediction.push(r)
			end

        elsif bestfit == exponential
			(0..18).each do |x|
				r = Rainfall.new
				r.rainfall = bestfit.coefficients[0] * (Math::E**(bestfit.coefficients[1] * (timeNow + (x*10))))
				rainfall_prediction.push(r)
			end
        end
        [rainfall_prediction, 1 - (bestfit.mse / 2000)]
	end
end
