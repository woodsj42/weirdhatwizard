class CreateDnd35eClassSpells < ActiveRecord::Migration
  def change
    create_table :dnd35e_class_spells do |t|
      t.integer :dnd35e_spell_id
      t.integer :dnd35e_class_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
