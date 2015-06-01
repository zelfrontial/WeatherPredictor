class WeatherController < ApplicationController
  def data
	@sources = Source.all
	@stations = Station.all
  	@readings = Reading.all
  	@single_readings = SingleReading.all


    #source finding is nil , fix it!
  	bom = Source.where(:name => "Bureau of Meteorology Australia").first
  	fio = Source.where(:name => "forecast.io").first

  	# Check latest reading
  	lastbom = Reading.where(:source_id => bom.id).order("created_at").last
  	lastfio = Reading.where(:source_id => fio.id).order("created_at").last

  	# Look at the whole table for matching reading.
  	@tablebom = SingleReading.joins(:station).where(:reading_id => lastbom.id)
  	@tablefio = SingleReading.joins(:station).where(:reading_id => lastfio.id)
  end

  def location
  	@all_station = Station.all

    respond_to do |format|
      format.html
      format.js
      format.json { render json: @weather_controller}
  	end
  end



  # def data_postcode

  # end

  # def data_loc_id

  # end

  # def prediction

  # end

end
