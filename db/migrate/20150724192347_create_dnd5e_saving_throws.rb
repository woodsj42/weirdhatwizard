class CreateDnd5eSavingThrows < ActiveRecord::Migration
  def change
    create_table :dnd5e_saving_throws do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
