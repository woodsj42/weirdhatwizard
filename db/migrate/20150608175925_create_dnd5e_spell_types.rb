class CreateDnd5eSpellTypes < ActiveRecord::Migration
  def change
    create_table :dnd5e_spell_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
