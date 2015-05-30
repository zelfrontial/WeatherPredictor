class AddDewPointToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :dew_point, index: true, foreign_key: true
  end
end
