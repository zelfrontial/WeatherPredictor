# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
source_list = [
	"Bureau of Meteorology Australia",
	"forecast.io"
]

station_list = [
	["Melbourne (Olympic Park)", -37.83, 144.98],
	["Melbourne Airport", -37.67, 144.83],
	["Avalon", -38.03, 144.48],
	["Cerberus", -38.36, 145.18],
	["Coldstream", -37.72, 145.41],
	["Essendon Airport", -37.73, 144.91],
	["Fawkner Beacon", -37.91, 144.93],
	["Ferny Creek", -37.87, 145.35],
	["Frankston", -38.15, 145.12],
	["Geelong Racecourse", -38.17, 144.38],
	["Laverton", -37.86, 144.76],
	["Moorabbin Airport", -37.98, 145.10],
	["Point Wilson", -38.10, 144.54],
	["Rhyll", -38.46, 145.31],
	["Scoresby", -37.87, 145.26],
	["Sheoaks", -37.91, 144.13],
	["South Channel Island", -38.31, 144.80],
	["St Kilda Harbour RMYS", -37.86, 144.96],
	["Viewbank", -37.74, 145.10]
]

source_list.each do |name|
	Source.create(name: name)
end

station_list.each do |name, latitude, longitude|
	Station.create(name: name, latitude: latitude, longitude: longitude)
end
