class AddGeolocationToStation < ActiveRecord::Migration
  def change
    add_reference :stations, :geolocation, index: true
    add_foreign_key :stations, :geolocations
  end
end
