class CreateRainfalls < ActiveRecord::Migration
  def change
    create_table :rainfalls do |t|
      t.float :rainfall

      t.timestamps null: false
    end
  end
end
