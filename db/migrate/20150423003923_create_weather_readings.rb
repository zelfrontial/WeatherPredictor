class CreateWeatherReadings < ActiveRecord::Migration
  def change
    create_table :weather_readings do |t|
      t.string :station_id
      t.float :lat
      t.float :long
      t.float :rainfall
      t.float :temperature
      t.float :dew_point
      t.string :wind_direction
      t.float :wind_speed
      t.string :date
      t.string :time
      t.string :source

      t.timestamps null: false
    end
  end
end
