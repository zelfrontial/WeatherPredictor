# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150524094455) do

  create_table "dew_points", force: :cascade do |t|
    t.float    "dewPoint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geolocations", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postcodes", force: :cascade do |t|
    t.integer  "postcode"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "geolocation_id"
  end

  add_index "postcodes", ["geolocation_id"], name: "index_postcodes_on_geolocation_id"

  create_table "rainfalls", force: :cascade do |t|
    t.float    "rainfall"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "readings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "source_id"
  end

  add_index "readings", ["source_id"], name: "index_readings_on_source_id"

  create_table "single_readings", force: :cascade do |t|
    t.datetime "time"
    t.float    "temperature"
    t.float    "rainfall"
    t.float    "dewPoint"
    t.float    "windSpeed"
    t.string   "windDirection"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "station_id"
    t.integer  "reading_id"
  end

  add_index "single_readings", ["reading_id"], name: "index_single_readings_on_reading_id"
  add_index "single_readings", ["station_id"], name: "index_single_readings_on_station_id"

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "stationID"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "geolocation_id"
  end

  add_index "stations", ["geolocation_id"], name: "index_stations_on_geolocation_id"

  create_table "temperatures", force: :cascade do |t|
    t.float    "temperature"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "winds", force: :cascade do |t|
    t.string   "windDirection"
    t.float    "windSpeed"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
