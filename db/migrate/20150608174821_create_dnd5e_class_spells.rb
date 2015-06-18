class CreateDnd5eClassSpells < ActiveRecord::Migration
  def change
    create_table :dnd5e_class_spells do |t|
    	t.belongs_to :dnd5e_class, index: true 
     	t.belongs_to :dnd5e_spell, index: true 
	t.string :level

      	t.timestamps null: false
    end
  end
end
