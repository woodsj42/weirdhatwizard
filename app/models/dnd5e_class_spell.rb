class Dnd5eClassSpell < ActiveRecord::Base
	
	def self.spells_known_to_class(id)

		where("dnd5e_class_id = ?", id).pluck(:dnd5e_spell_id).map{ |m| m = Dnd5eSpell.where("id = ?", m).take}

	end
end
