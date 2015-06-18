class CreateDnd5eArchetypes < ActiveRecord::Migration
  def change
    create_table :dnd5e_archetypes do |t|
      t.string :name
      t.belongs_to :dnd5e_class, index: true 

      t.timestamps null: false
    end
  end
end
