class CreateDnd35eSpells < ActiveRecord::Migration
  def change
    create_table :dnd35e_spells do |t|
      t.string :name
      t.string :description
      t.string :spell_type
      t.string :area
      t.string :target
      t.string :components
      t.string :cast_time
      t.string :duration
      t.string :saving_throw
      t.string :spell_resistance
      t.string :tags

      t.timestamps null: false
    end
  end
end
