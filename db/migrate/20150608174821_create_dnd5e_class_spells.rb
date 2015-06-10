class CreateDnd5eClassSpells < ActiveRecord::Migration
  def change
    create_table :dnd5e_class_spells do |t|
      t.integer :dnd5e_class_id
      t.integer :dnd5e_spell_id

      t.timestamps null: false
    end
  end
end
