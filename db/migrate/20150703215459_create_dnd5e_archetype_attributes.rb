class CreateDnd5eArchetypeAttributes < ActiveRecord::Migration
  def change
    create_table :dnd5e_archetype_attributes do |t|
      t.string :name
      t.string :value
      t.string :description
      t.string :level
      t.belongs_to :dnd5e_archetype, index: true

      t.timestamps null: false
    end
  end
end
