class AddWindToSingleReading < ActiveRecord::Migration
  def change
    add_reference :single_readings, :wind, index: true, foreign_key: true
  end
end
