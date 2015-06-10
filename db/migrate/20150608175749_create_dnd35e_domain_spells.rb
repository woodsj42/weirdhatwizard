class CreateDnd35eDomainSpells < ActiveRecord::Migration
  def change
    create_table :dnd35e_domain_spells do |t|
      t.integer :dnd35e_spell_id
      t.integer :dnd35e_domain_id
      t.string :level

      t.timestamps null: false
    end
  end
end
