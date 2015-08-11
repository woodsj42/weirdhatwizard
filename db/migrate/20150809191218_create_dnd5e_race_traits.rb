class CreateDnd5eRaceTraits < ActiveRecord::Migration
  def change
    create_table :dnd5e_race_traits do |t|
      t.string :name
      t.belongs_to :dnd5e_race, index: true, foreign_key: true
      t.string :description

      t.timestamps null: false
    end
  end
end
