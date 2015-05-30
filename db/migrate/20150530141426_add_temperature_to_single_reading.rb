class AddTemperatureToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :temperature, index: true, foreign_key: true
  end
end
