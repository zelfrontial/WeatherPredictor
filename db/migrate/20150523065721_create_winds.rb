class CreateWinds < ActiveRecord::Migration
  def change
    create_table :winds do |t|
      t.String :windDirection
      t.float :windSpeed

      t.timestamps null: false
    end
  end
end
