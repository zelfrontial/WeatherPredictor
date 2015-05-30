class RemoveRainfallfromSingleReading < ActiveRecord::Migration
  def change
  	remove_column :single_readings, :temperature 
  	remove_column :single_readings,:rainfall 
  	remove_column :single_readings,:dewPoint 
  	remove_column :single_readings,:windSpeed
  	remove_column :single_readings,:windDirection
  end
end
