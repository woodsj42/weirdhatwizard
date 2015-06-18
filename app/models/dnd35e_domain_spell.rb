class Dnd35eDomainSpell < ActiveRecord::Base
	
	belongs_to :dnd35e_domain
	belongs_to :dnd35e_spell
	
	def self.spells_known_to_domain_by_level(id)

		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		where(dnd35e_domain_id: id).map { |m| 
							temp = m.level.to_i
					        	@sorted[ temp ][ length[temp] ] = m
							length[temp] += 1 
		 			      }
		@sorted
	end
end
