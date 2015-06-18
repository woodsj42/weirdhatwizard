class CreateDnd5eCastTimes < ActiveRecord::Migration
  def change
    create_table :dnd5e_cast_times do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
