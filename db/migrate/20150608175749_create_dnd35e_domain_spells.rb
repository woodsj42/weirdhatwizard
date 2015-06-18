class CreateDnd35eDomainSpells < ActiveRecord::Migration
  def change
    create_table :dnd35e_domain_spells do |t|
     	t.belongs_to :dnd35e_domain, index: true
	t.belongs_to :dnd35e_spell, index: true 
	t.string :level

      	t.timestamps null: false
    end
  end
end
