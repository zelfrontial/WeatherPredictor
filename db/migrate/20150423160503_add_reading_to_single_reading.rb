class AddReadingToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :reading, index: true
    add_foreign_key :single_readings, :readings
  end
end
