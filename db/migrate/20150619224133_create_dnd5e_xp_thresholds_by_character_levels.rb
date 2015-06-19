class CreateDnd5eXpThresholdsByCharacterLevels < ActiveRecord::Migration
  def change
    create_table :dnd5e_xp_thresholds_by_character_levels do |t|
      t.string :character_level
      t.string :easy
      t.string :medium
      t.string :hard
      t.string :deadly

      t.timestamps null: false
    end
  end
end
