#############################################################################
# SWEN30006-2015-SEM1 Software Modelling and Design
# Project 1
#
# Author: Adrian Sutanahadi
# Student ID: 617462 
#############################################################################

require 'csv'
require 'matrix'

#############################################################################
# the parent Regression class
class Regression
    attr_reader :coefficients
    attr_reader :mse

    def initialize x_array, y_array
        @x_array = x_array
        @y_array = y_array
        @coefficients = Array.new
        @y_approx_array = Array.new
        @mse = 0.0
    end

    # find mean squared error, formula taken from http://en.wikipedia.org/wiki/Mean_squared_error
    def find_mse y_input_array, y_approx_array
        mse = 0.0
        (0..(y_input_array.count-1)).each { |i| mse += (y_input_array[i] - y_approx_array[i])**2 }
        mse /= y_input_array.count
    end
end

#############################################################################
# Polynomial regression with a maximum degree of 10
class PolynomialRegression < Regression
    attr_reader :degree
    def initialize x_array, y_array
        super(x_array, y_array)
        @degree = 0
    end

    def process_regression
        lowest = []

        # check for the lowest MSE between 2 - 10 degree polynomial
        (2..10).each do |i|
            coefficients = regress i
            temp_y_approx_array = find_y_approx(coefficients, @x_array, i)
            temp_mse = find_mse(@y_array, temp_y_approx_array)
            if ((lowest == []) || (temp_mse < lowest[1]))
                lowest = [coefficients, temp_mse, temp_y_approx_array, i]
            end
        end

        # store the information in the instance variables
        @coefficients = lowest[0]
        @mse = lowest[1]
        @y_approx_array = lowest[2]
        @degree = lowest[3]
    end

    # regression formula adapted from the spec sheet
    def regress degree
        x_data = @x_array.map { |x_i| (0..degree).map { |pow| (x_i**pow).to_f } }
        mx = Matrix[*x_data]
        my = Matrix.column_vector(@y_array)
        (((mx.t * mx).inv * mx.t * my).round(2)).transpose.to_a[0]
    end

    # derive the approximated y points based on equation from regression
    def find_y_approx coefficients, x_array, degree
        y_approx_array = Array.new
        x_array.each do |x|
            y = 0.0
            (0..degree).each { |i| y += coefficients[i] * (x**i) }
            y_approx_array.push(y)
        end
        y_approx_array
    end

    # print the equation
    def print_equation
        (0..@degree).to_a.reverse.each do |i|
            unless (@coefficients[i] == 0)
                print "#{@coefficients[i]}"
                unless (i == 0)
                    print "x"
                    print "^#{i}" if (i > 1)
                    print " + "
                end
            end
        end
        print "\n"
    end
end

#############################################################################
# Linear regression is a polynomial regression with a degree of 1
class LinearRegression < PolynomialRegression
    attr_reader :degree
    def initialize x_array, y_array
        super(x_array, y_array)
        @degree = 1
    end

    def process_regression
        @coefficients = regress @degree
        @y_approx_array = find_y_approx(@coefficients, @x_array, @degree)
        @mse = find_mse(@y_array, @y_approx_array)
    end
end

#############################################################################
# Least Squared Fitting -- Logarithmic Regression
class LogarithmicRegression < Regression
    def initialize x_array, y_array
        super(x_array, y_array)
    end

    def process_regression
        @coefficients = logarithmic_regress
        @y_approx_array = find_y_approx(@coefficients, @x_array)
        @mse = find_mse(@y_array, @y_approx_array)
    end

    # least square fitting logarithmic regression formula taken from http://mathworld.wolfram.com/LeastSquaresFittingLogarithmic.html
    def logarithmic_regress
        n = @x_array.count

        sig_ylnx = 0.0
        sig_lnx2 = 0.0
        sig_lnx = 0.0
        sig_y = 0.0
        (0..n-1).each do |i|
            sig_ylnx += @y_array[i] * Math.log(@x_array[i])
            sig_lnx2 += (Math.log(@x_array[i]))**2
            sig_lnx += Math.log(@x_array[i])
            sig_y += @y_array[i]
        end

        b = ((n * (sig_ylnx)) - (sig_y * sig_lnx)) / ((n * (sig_lnx2)) - (sig_lnx**2))
        a = (sig_y - (b * sig_lnx)) / n

        [a.round(2), b.round(2)]
    end

    # derive the approximated y points based on equation from regression
    def find_y_approx coefficients, x_array
        y_approx_array = Array.new
        x_array.each { |x| y_approx_array.push(coefficients[0] + (coefficients[1] * Math.log(x))) }
        y_approx_array
    end

    # print the equation
    def print_equation
        puts "#{@coefficients[1]}*ln(x) + #{@coefficients[0]}"
    end
end

#############################################################################
# Least Squared Fitting -- Exponential Regression
class ExponentialRegression < Regression
    def initialize x_array, y_array
        super(x_array, y_array)
    end

    def process_regression
        @coefficients = exponential_regress
        @y_approx_array = find_y_approx(@coefficients, @x_array)
        @mse = find_mse(@y_array, @y_approx_array)
    end

    # least squares fitting exponential regression formula from http://mathworld.wolfram.com/LeastSquaresFittingExponential.html
    def exponential_regress
        n = @x_array.count

        sig_lny = 0.0
        sig_x2 = 0.0
        sig_x = 0.0
        sig_xlny = 0.0
        (0..n-1).each do |i|
            sig_lny += Math.log(@y_array[i])
            sig_x2 += @x_array[i]**2
            sig_x += @x_array[i]
            sig_xlny += @x_array[i] * Math.log(@y_array[i])
        end
        a = Math::E**(((sig_lny * sig_x2) - (sig_x * sig_xlny)) / ((n * sig_x2) - (sig_x**2)))
        b = (((n * sig_xlny) - (sig_x * sig_lny)) / ((n * sig_x2) - (sig_x**2)))

        [a.round(2), b.round(2)]
    end

    # derive the approximated y points based on equation from regression
    def find_y_approx coefficients, x_array
        y_approx_array = Array.new
        @x_array.each { |x| y_approx_array.push(coefficients[0] * (Math::E**(coefficients[1] * x))) }
        y_approx_array
    end

    # print the equation
    def print_equation
        puts "#{@coefficients[0]}*e^#{@coefficients[1]}x"
    end
end

# #############################################################################
# # adapted from http://technicalpickles.com/posts/parsing-csv-with-ruby/
# # parse csv to arrays
# def parse_csv csvfile
#     csv = CSV.new(open(csvfile), :headers => true)
#     csv_array = csv.to_a
#     x_array = Array.new
#     y_array = Array.new
#     csv_array.each do |e|
#         x_array.push(e[0].to_f)
#         y_array.push(e[1].to_f)
#     end
#     [x_array, y_array]
# end

# #############################################################################
# # determine best fit between the 4 regression models by comparing MSE
# def check_best_fit linear, polynomial, logarithmic, exponential
#     best_fit = linear
#     [polynomial, logarithmic, exponential].each { |reg| best_fit = reg if reg.mse < best_fit.mse unless reg == nil }
#     best_fit
# end

# #############################################################################
# # main function
# def main
#     input = parse_csv(ARGV[0])

#     # case when linear regression is chosen
#     if ((ARGV[1] == "linear") or (ARGV[1] == "best_fit"))
#         linear = LinearRegression.new(input[0], input[1])
#         linear.process_regression

#         print "Linear Equation = " if ARGV[2] == "mse"
#         linear.print_equation if ((ARGV[1] == "linear") or (ARGV[2] == "mse"))
#         puts "Linear MSE = #{linear.mse}" if ARGV[2] == "mse"
#     end

#     # case when polynomial regression is chosen
#     if ((ARGV[1] == "polynomial") or (ARGV[1] == "best_fit"))
#         polynomial = PolynomialRegression.new(input[0], input[1])
#         polynomial.process_regression

#         print "Polynomial Equation = " if ARGV[2] == "mse"
#         polynomial.print_equation if ((ARGV[1] == "polynomial") or (ARGV[2] == "mse"))
#         puts "Polynomial MSE = #{polynomial.mse}" if ARGV[2] == "mse"
#     end

#     # case when logarithmic regression is chosen, also detects when it cannot be performed
#     begin
#         if ((ARGV[1] == "logarithmic") or (ARGV[1] == "best_fit"))
#             logarithmic = LogarithmicRegression.new(input[0], input[1])
#             logarithmic.process_regression

#             print "Logarithmic Equation = " if ARGV[2] == "mse"
#             logarithmic.print_equation if ((ARGV[1] == "logarithmic") or (ARGV[2] == "mse"))
#             puts "Logarithmic MSE = #{logarithmic.mse}" if ARGV[2] == "mse"
#         end
#     rescue Math::DomainError
#         puts "Cannot perform logarithmic regression on this data" unless ((ARGV[1] == "best_fit") and (ARGV[2] != "mse"))
#         logarithmic = nil
#     end

#     # case when exponential regression is chosen, also detects when it cannot be performed
#     begin
#         if ((ARGV[1] == "exponential") or (ARGV[1] == "best_fit"))
#             exponential = ExponentialRegression.new(input[0], input[1])
#             exponential.process_regression

#             print "Exponential Equation = " if ARGV[2] == "mse"
#             exponential.print_equation if ((ARGV[1] == "exponential") or (ARGV[2] == "mse"))
#             puts "Exponential MSE = #{exponential.mse}" if ARGV[2] == "mse"
#         end
#     rescue Math::DomainError
#         puts "Cannot perform exponential regression on this data" unless ((ARGV[1] == "best_fit") and (ARGV[2] != "mse"))
#         exponential = nil
#     end

#     # determine the best fit from the 4 regression model if best fit mode is chosen
#     if (ARGV[1] == "best_fit")
#         best_fit = check_best_fit(linear, polynomial, logarithmic, exponential)

#         print "Best Fit Equation = " if ARGV[2] == "mse"
#         best_fit.print_equation
#     end
# end

# #############################################################################
# # run the program
# main
