class Dnd35eClassSpell < ActiveRecord::Base

	belongs_to :dnd35e_spell
	belongs_to :dnd35e_class

	def self.spells_known_to_class_by_level(id)

		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		where(dnd35e_class_id: id).map { |m| 
							temp = m.level.to_i
					        	@sorted[ temp ][ length[temp] ] = Dnd35eSpell.find(m.dnd35e_spell_id)
							length[temp] += 1 
		 			      }
		@sorted
	end
	
	def self.classes_that_know_this_spell_by_level(id)

		Dnd35eClass.includes(:dnd35e_class_spells).where(:dnd35e_class_spells => {dnd35e_spell_id: id})
	end
end
