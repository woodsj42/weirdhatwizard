class CreateDnd5eRaces < ActiveRecord::Migration
  def change
    create_table :dnd5e_races do |t|
      t.string :name
      t.string :str
      t.string :dex
      t.string :con
      t.string :int
      t.string :wis
      t.string :cha
      t.string :speed
      t.string :size
      t.string :languages
      t.string :description

      t.timestamps null: false
    end
  end
end
