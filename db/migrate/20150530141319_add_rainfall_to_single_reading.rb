class AddRainfallToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :rainfall, index: true, foreign_key: true
  end
end
