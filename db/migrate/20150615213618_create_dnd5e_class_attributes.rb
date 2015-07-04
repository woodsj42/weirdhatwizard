class CreateDnd5eClassAttributes < ActiveRecord::Migration
  def change
    create_table :dnd5e_class_attributes do |t|
      t.string :name
      t.string :value
      t.string :description
      t.string :level
      t.belongs_to :dnd5e_class, index: true 

      t.timestamps null: false
    end
  end
end
