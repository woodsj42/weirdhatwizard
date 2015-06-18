class CreateDnd35eDurations < ActiveRecord::Migration
  def change
    create_table :dnd35e_durations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
