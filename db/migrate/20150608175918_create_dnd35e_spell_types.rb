class CreateDnd35eSpellTypes < ActiveRecord::Migration
  def change
    create_table :dnd35e_spell_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
