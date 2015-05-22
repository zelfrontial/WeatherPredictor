class WeatherController < ApplicationController
  def data
	@sources = Source.all
	@stations = Station.all
  	@readings = Reading.all
  	@single_readings = SingleReading.all

  	bom = Source.where(:name => "Bureau of Meteorology Australia").first
  	fio = Source.where(:name => "forecast.io").first

  	# Check latest reading
  	lastbom = Reading.where(:source_id => bom.id).order("created_at").last
  	lastfio = Reading.where(:source_id => fio.id).order("created_at").last

  	# Look at the whole table for matching reading.
  	@tablebom = SingleReading.joins(:station).where(:reading_id => lastbom.id)
  	@tablefio = SingleReading.joins(:station).where(:reading_id => lastfio.id)
  end
end
