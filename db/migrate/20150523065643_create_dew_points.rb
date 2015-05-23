class CreateDewPoints < ActiveRecord::Migration
  def change
    create_table :dew_points do |t|
      t.float :dewPoint

      t.timestamps null: false
    end
  end
end
