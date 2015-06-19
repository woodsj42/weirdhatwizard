class CreateDnd5eEncounterMultipliers < ActiveRecord::Migration
  def change
    create_table :dnd5e_encounter_multipliers do |t|
      t.string :number_of_monsters
      t.string :multiplier
      t.string :number_of_characters

      t.timestamps null: false
    end
  end
end
