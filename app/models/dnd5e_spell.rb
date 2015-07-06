class Dnd5eSpell < ActiveRecord::Base
	
	has_many :dnd5e_class_spells
	has_many :dnd5e_classes, :through => :dnd5e_class_spells	
	has_many :dnd5e_archetype_spells
	has_many :dnd5e_archetypes, :through => :dnd5e_archetype_spells	

	def self.sort_by_level
		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		Dnd5eSpell.all.map { |m| 
				      	temp = m.level.to_i 	
					@sorted[ temp ][ length[ temp ] ] = m
					length[temp] += 1 
	     			   }
		@sorted
	end
	
	def self.sort_by_tag(id)
		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		tag = SpellTag.find(id)
		Dnd5eSpell.all.map { |m| 
					if m.tags.split(',').detect {|i| i == tag.name}
				      		temp = m.level.to_i 	
						@sorted[ temp ][ length[ temp ] ] = m
						length[temp] += 1 
					end
	     			   }
		@sorted
	end
	

	def self.search(query)
#		where(:name query)
		where("name like ?", "%#{query}%")
	end

end
