class CreateSingleReadings < ActiveRecord::Migration
  def change
    create_table :single_readings do |t|
      t.datetime :time
      t.float :temperature
      t.float :rainfall
      t.float :dewPoint
      t.float :windSpeed
      t.string :windDirection

      t.timestamps null: false
    end
  end
end
