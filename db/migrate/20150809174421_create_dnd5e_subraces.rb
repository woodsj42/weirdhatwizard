class CreateDnd5eSubraces < ActiveRecord::Migration
  def change
    create_table :dnd5e_subraces do |t|
      t.string :name
      t.string :str
      t.string :dex
      t.string :con
      t.string :int
      t.string :wis
      t.string :cha
      t.string :description
      t.belongs_to :dnd5e_race, index: true

      t.timestamps null: false
    end
  end
end
