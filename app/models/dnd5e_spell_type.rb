class Dnd5eSpellType < ActiveRecord::Base
	
	def self.spells_of_certain_type_by_level(name)

		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
#		Dnd5eSpell.includes(:dnd5e_spell_types).where(:dnd5e_spell_types => {dnd5e_spell_type_id: id})
		Dnd5eSpell.all.each do |spell|
		
			if spell.spell_type == name
				temp = spell.level.to_i
                        	@sorted[ temp ][ length[ temp ] ] = spell
                        	length[temp] += 1
			end
			
		end
		@sorted	
	end
	
	def self.spells_of_certain_type_by_level_dnd35e(name)

		@sorted = []
#		Dnd5eSpell.includes(:dnd5e_spell_types).where(:dnd5e_spell_types => {dnd5e_spell_type_id: id})
		Dnd35eSpell.all.each do |spell|

			spell.spell_type.split(', ').each do |n|	
				if n == name
                        		@sorted <<  spell
				end
			end
			
		end
		@sorted	
	end
end
