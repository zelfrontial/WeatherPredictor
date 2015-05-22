class AddStationToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :station, index: true
    add_foreign_key :single_readings, :stations
  end
end
