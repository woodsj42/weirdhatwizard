class CreateDnd35eClasses < ActiveRecord::Migration
  def change
    create_table :dnd35e_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
