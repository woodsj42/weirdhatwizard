class Dnd5eArchetypeSpell < ActiveRecord::Base

	def self.spells_known_to_archetype(id)

		where("dnd5e_archetype_id = ?", id).pluck(:dnd5e_spell_id).map{ |m| m = Dnd5eSpell.where("id = ?", m).take}
	end
end
