class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :station_id
      t.float :lat
      t.float :long
      t.integer :post_code

      t.timestamps null: false
    end
  end
end
