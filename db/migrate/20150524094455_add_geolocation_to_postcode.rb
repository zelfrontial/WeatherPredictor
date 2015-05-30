class AddGeolocationToPostcode < ActiveRecord::Migration
  def change
    add_reference :postcodes, :geolocation, index: true
    add_foreign_key :postcodes, :geolocations
  end
end
