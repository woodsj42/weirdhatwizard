class CreateDnd5eClasses < ActiveRecord::Migration
  def change
    create_table :dnd5e_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
