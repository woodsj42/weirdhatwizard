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

ActiveRecord::Schema.define(version: 20150703215459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dnd35e_cast_times", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd35e_class_spells", force: :cascade do |t|
    t.integer  "dnd35e_class_id"
    t.integer  "dnd35e_spell_id"
    t.string   "level"
    t.string   "class_level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "dnd35e_class_spells", ["dnd35e_class_id"], name: "index_dnd35e_class_spells_on_dnd35e_class_id", using: :btree
  add_index "dnd35e_class_spells", ["dnd35e_spell_id"], name: "index_dnd35e_class_spells_on_dnd35e_spell_id", using: :btree

  create_table "dnd35e_classes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd35e_components", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd35e_domain_spells", force: :cascade do |t|
    t.integer  "dnd35e_domain_id"
    t.integer  "dnd35e_spell_id"
    t.string   "level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "dnd35e_domain_spells", ["dnd35e_domain_id"], name: "index_dnd35e_domain_spells_on_dnd35e_domain_id", using: :btree
  add_index "dnd35e_domain_spells", ["dnd35e_spell_id"], name: "index_dnd35e_domain_spells_on_dnd35e_spell_id", using: :btree

  create_table "dnd35e_domains", force: :cascade do |t|
    t.string   "name"
    t.string   "granted_power"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dnd35e_durations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "tags"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "dnd5e_archetype_attributes", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.string   "description"
    t.string   "level"
    t.integer  "dnd5e_archetype_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "dnd5e_archetype_attributes", ["dnd5e_archetype_id"], name: "index_dnd5e_archetype_attributes_on_dnd5e_archetype_id", using: :btree

  create_table "dnd5e_archetype_spells", force: :cascade do |t|
    t.integer  "dnd5e_archetype_id"
    t.integer  "dnd5e_spell_id"
    t.string   "level"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "dnd5e_archetype_spells", ["dnd5e_archetype_id"], name: "index_dnd5e_archetype_spells_on_dnd5e_archetype_id", using: :btree
  add_index "dnd5e_archetype_spells", ["dnd5e_spell_id"], name: "index_dnd5e_archetype_spells_on_dnd5e_spell_id", using: :btree

  create_table "dnd5e_archetypes", force: :cascade do |t|
    t.string   "name"
    t.integer  "dnd5e_class_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "dnd5e_archetypes", ["dnd5e_class_id"], name: "index_dnd5e_archetypes_on_dnd5e_class_id", using: :btree

  create_table "dnd5e_cast_times", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd5e_class_attributes", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.string   "description"
    t.string   "level"
    t.integer  "dnd5e_class_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "dnd5e_class_attributes", ["dnd5e_class_id"], name: "index_dnd5e_class_attributes_on_dnd5e_class_id", using: :btree

  create_table "dnd5e_class_spells", force: :cascade do |t|
    t.integer  "dnd5e_class_id"
    t.integer  "dnd5e_spell_id"
    t.string   "level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "dnd5e_class_spells", ["dnd5e_class_id"], name: "index_dnd5e_class_spells_on_dnd5e_class_id", using: :btree
  add_index "dnd5e_class_spells", ["dnd5e_spell_id"], name: "index_dnd5e_class_spells_on_dnd5e_spell_id", using: :btree

  create_table "dnd5e_classes", force: :cascade do |t|
    t.string   "name"
    t.string   "weapon_proficiencies"
    t.string   "skill_proficiencies"
    t.string   "armor_proficiencies"
    t.string   "saving_throws"
    t.string   "tools"
    t.string   "hit_die"
    t.string   "main_ability"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "dnd5e_components", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd5e_durations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dnd5e_encounter_multipliers", force: :cascade do |t|
    t.string   "number_of_monsters"
    t.string   "multiplier"
    t.string   "number_of_characters"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "dnd5e_monsters", force: :cascade do |t|
    t.string   "name"
    t.string   "size"
    t.string   "alignment1"
    t.string   "alignment2"
    t.string   "categories"
    t.string   "xp"
    t.string   "cr"
    t.string   "creature_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
    t.string   "tags"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "dnd5e_xp_thresholds_by_character_levels", force: :cascade do |t|
    t.string   "character_level"
    t.string   "easy"
    t.string   "medium"
    t.string   "hard"
    t.string   "deadly"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "monster_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
