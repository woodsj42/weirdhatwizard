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

ActiveRecord::Schema.define(version: 20150609221318) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dnd35e_class_spells", force: :cascade do |t|
    t.integer  "dnd35e_spell_id"
    t.integer  "dnd35e_class_id"
    t.string   "level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "dnd35e_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd35e_domain_spells", force: :cascade do |t|
    t.integer  "dnd35e_spell_id"
    t.integer  "dnd35e_domain_id"
    t.string   "level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "dnd35e_domains", force: :cascade do |t|
    t.string   "name"
    t.string   "granted_power"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dnd35e_spell_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd35e_spells", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "spell_type"
    t.string   "area"
    t.string   "target"
    t.string   "components"
    t.string   "cast_time"
    t.string   "duration"
    t.string   "saving_throw"
    t.string   "spell_resistance"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "dnd5e_archetype_spells", force: :cascade do |t|
    t.integer  "dnd5e_archetype_id"
    t.integer  "dnd5e_spell_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "dnd5e_archetypes", force: :cascade do |t|
    t.string   "name"
    t.integer  "dnd5e_class_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dnd5e_class_spells", force: :cascade do |t|
    t.integer  "dnd5e_class_id"
    t.integer  "dnd5e_spell_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dnd5e_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd5e_spell_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd5e_spells", force: :cascade do |t|
    t.string   "name"
    t.string   "level"
    t.string   "spell_type"
    t.string   "cast"
    t.string   "range"
    t.string   "components"
    t.string   "duration"
    t.string   "description"
    t.string   "ritual"
    t.string   "concentration"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
