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

ActiveRecord::Schema.define(version: 20140927211615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eto_calculations", force: true do |t|
    t.date    "date"
    t.float   "eto"
    t.integer "weather_station_id"
  end

  add_index "eto_calculations", ["weather_station_id"], name: "index_eto_calculations_on_weather_station_id", using: :btree

  create_table "recommendations", force: true do |t|
    t.integer  "yards_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "weekly_precipitation"
    t.float    "weekly_eto"
    t.float    "min_req_water"
    t.float    "max_req_water"
    t.float    "min_irrigation"
    t.float    "max_irrigation"
    t.integer  "min_minutes"
    t.integer  "max_minutes"
  end

  create_table "solar_data", force: true do |t|
    t.date     "date"
    t.float    "solar_reading"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "address"
    t.string   "zip"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "contact_method"
    t.string   "email"
    t.string   "phone"
    t.string   "login_email"
    t.string   "profile_pic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "formatted_address"
    t.integer  "weather_station_id"
  end

  add_index "users", ["weather_station_id"], name: "index_users_on_weather_station_id", using: :btree

  create_table "weather_data", force: true do |t|
    t.integer  "weather_station_id"
    t.date     "date"
    t.float    "mean_temperature"
    t.float    "minimum_temperature"
    t.float    "maximum_temperature"
    t.float    "wind_speed"
    t.float    "minimum_humidity"
    t.float    "maximum_humidity"
    t.float    "minimum_dewpoint"
    t.float    "maximum_dewpoint"
    t.float    "precipitation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weather_stations", force: true do |t|
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "kind"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bad_data",   default: false
  end

  create_table "yards", force: true do |t|
    t.integer  "user_id"
    t.string   "grass"
    t.string   "sprinkler"
    t.string   "sprinkler_flow"
    t.string   "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day_number"
  end

end
