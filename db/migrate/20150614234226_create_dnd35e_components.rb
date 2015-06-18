class CreateDnd35eComponents < ActiveRecord::Migration
  def change
    create_table :dnd35e_components do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
