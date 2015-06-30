class CreateDnd5eSpells < ActiveRecord::Migration
  def change
    create_table :dnd5e_spells do |t|
      t.string :name
      t.string :level
      t.string :spell_type
      t.string :cast
      t.string :range
      t.string :components
      t.string :duration
      t.string :description
      t.string :ritual
      t.string :concentration
      t.string :tags

      t.timestamps null: false
    end
  end
end
