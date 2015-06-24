class CreateDnd35eClassSpells < ActiveRecord::Migration
  def change
    create_table :dnd35e_class_spells do |t|
      	t.belongs_to :dnd35e_class, index: true
	t.belongs_to :dnd35e_spell, index: true
	t.string :level
	t.string :class_level

      	t.timestamps null: false
    end
  end
end
