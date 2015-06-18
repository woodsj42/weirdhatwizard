class CreateDnd5eDurations < ActiveRecord::Migration
  def change
    create_table :dnd5e_durations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
