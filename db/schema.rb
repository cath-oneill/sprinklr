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

ActiveRecord::Schema.define(version: 20140923042137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.integer  "start_hr"
    t.integer  "start_min"
    t.integer  "end_hr"
    t.integer  "end_min"
    t.string   "day"
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
  end

  create_table "yards", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "slope"
    t.string   "soil"
    t.string   "grass"
    t.string   "sprinkler"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "yards_schedules", force: true do |t|
    t.integer  "schedule_id"
    t.integer  "yard_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
