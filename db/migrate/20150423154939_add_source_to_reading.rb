class AddSourceToReading < ActiveRecord::Migration
  def change
    add_reference :readings, :source, index: true
    add_foreign_key :readings, :sources
  end
end
