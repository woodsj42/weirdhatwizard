class CreateDnd5eArchetypeSpells < ActiveRecord::Migration
  def change
    create_table :dnd5e_archetype_spells do |t|
      t.integer :dnd5e_archetype_id
      t.integer :dnd5e_spell_id

      t.timestamps null: false
    end
  end
end
