class CreateDnd5eComponents < ActiveRecord::Migration
  def change
    create_table :dnd5e_components do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
