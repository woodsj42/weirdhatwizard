class CreateDnd35eCastTimes < ActiveRecord::Migration
  def change
    create_table :dnd35e_cast_times do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
