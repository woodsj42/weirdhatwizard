class Dnd35eDomainSpell < ActiveRecord::Base
	def self.spells_known_to_domain(id)

		where("dnd35e_domain_id = ?", id)	

	end
end
