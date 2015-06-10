class CreateDnd5eArchetypes < ActiveRecord::Migration
  def change
    create_table :dnd5e_archetypes do |t|
      t.string :name
      t.integer :dnd5e_class_id

      t.timestamps null: false
    end
  end
end
