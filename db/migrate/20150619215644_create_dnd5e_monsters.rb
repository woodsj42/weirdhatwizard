class CreateDnd5eMonsters < ActiveRecord::Migration
  def change
    create_table :dnd5e_monsters do |t|
      t.string :name
      t.string :size
      t.string :alignment1
      t.string :alignment2
      t.string :categories
      t.string :xp
      t.string :cr
      t.string :creature_type

      t.timestamps null: false
    end
  end
end
