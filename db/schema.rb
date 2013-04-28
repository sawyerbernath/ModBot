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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130428010138) do

  create_table "build_reports", :force => true do |t|
    t.string   "title"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "_passed"
    t.integer  "_failed"
    t.float    "_hours"
    t.integer  "Assemble Drive Halves_passed"
    t.integer  "Assemble Drive Halves_failed"
    t.float    "Assemble Drive Halves_hours"
    t.integer  "Mate Cubes_passed"
    t.integer  "Mate Cubes_failed"
    t.float    "Mate Cubes_hours"
    t.integer  "Test Passives_passed"
    t.integer  "Test Passives_failed"
    t.float    "Test Passives_hours"
    t.integer  "Circuit Boarding_passed"
    t.integer  "Circuit Boarding_failed"
    t.float    "Circuit Boarding_hours"
  end

  create_table "elves", :force => true do |t|
    t.string   "name"
    t.integer  "task_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "task_types", :force => true do |t|
    t.string   "name"
    t.integer  "batch_size"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tasks", :force => true do |t|
    t.integer  "quantity"
    t.text     "notes"
    t.string   "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "elf_id"
    t.integer  "task_type_id"
    t.integer  "passed"
    t.integer  "failed"
  end

end
