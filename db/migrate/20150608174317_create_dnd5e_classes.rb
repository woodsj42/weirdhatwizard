class CreateDnd5eClasses < ActiveRecord::Migration
  def change
    create_table :dnd5e_classes do |t|
	t.string :name
	t.string :weapon_proficiencies
	t.string :skill_proficiencies
	t.string :armor_proficiencies
	t.string :saving_throws
	t.string :tools
	t.string :hit_die
	t.string :main_ability

      t.timestamps null: false
    end
  end
end
