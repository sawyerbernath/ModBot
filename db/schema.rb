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
    t.integer  "assemble_drive_halves_passed"
    t.integer  "assemble_drive_halves_failed"
    t.float    "assemble_drive_halves_hours"
    t.integer  "mate_cubes_passed"
    t.integer  "mate_cubes_failed"
    t.float    "mate_cubes_hours"
    t.integer  "test_passives_passed"
    t.integer  "test_passives_failed"
    t.float    "test_passives_hours"
    t.integer  "circuit_boarding_passed"
    t.integer  "circuit_boarding_failed"
    t.float    "circuit_boarding_hours"
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
