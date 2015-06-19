class CreateMonsterCategories < ActiveRecord::Migration
  def change
    create_table :monster_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
