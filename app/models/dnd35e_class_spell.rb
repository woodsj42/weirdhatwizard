class Dnd35eClassSpell < ActiveRecord::Base
	def self.spells_known_to_class(id)

		where("dnd35e_class_id = ?", id).pluck(:dnd35e_spell_id).map{ |m| m = Dnd35eSpell.where("id = ?", m).take}

	end
end
