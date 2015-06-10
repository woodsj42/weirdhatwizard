class CreateDnd35eDomains < ActiveRecord::Migration
  def change
    create_table :dnd35e_domains do |t|
      t.string :name
      t.string :granted_power

      t.timestamps null: false
    end
  end
end
