class CreateDnd5eArchetypes < ActiveRecord::Migration
  def change
    create_table :dnd5e_archetypes do |t|
      t.string :name
      t.integer :dnd5e_class_id
      t.belongs_to :ddn5e_class, :index true

      t.timestamps null: false
    end
      add_index :dnd5e_archetypes, [:dnd5e_class_id]
  end
end
