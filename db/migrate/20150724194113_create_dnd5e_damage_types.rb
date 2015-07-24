class CreateDnd5eDamageTypes < ActiveRecord::Migration
  def change
    create_table :dnd5e_damage_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
