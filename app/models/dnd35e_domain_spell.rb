class Dnd35eDomainSpell < ActiveRecord::Base
	
	belongs_to :dnd35e_domain
	belongs_to :dnd35e_spell
	
	def self.spells_known_to_domain(id)

		where("dnd35e_domain_id = ?", id)	

	end
end
