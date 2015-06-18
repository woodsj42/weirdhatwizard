class Dnd5eClassSpell < ActiveRecord::Base
	
	belongs_to :dnd5e_class
	belongs_to :dnd5e_spell
	
	def self.spells_known_to_class_by_level(id)

		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		Dnd5eSpell.includes(:dnd5e_class_spells).where(:dnd5e_class_spells => {dnd5e_class_id: id}).map { |m| 
															temp = m.level.to_i 	
														        @sorted[ temp ][ length[ temp ] ] = m  
															length[temp] += 1 
														}
		@sorted
	end
end
