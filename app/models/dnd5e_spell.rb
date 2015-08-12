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
	
	def self.sort_by_saving_throw(id)
		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		st = Dnd5eSavingThrow.find(id)
		Dnd5eSpell.all.map { |m|
					if m.saving_throw and m.saving_throw.split(', ').detect {|i| i == st.name} 
				      		temp = m.level.to_i 	
						@sorted[ temp ][ length[ temp ] ] = m
						length[temp] += 1 
					end
	     			   }
		@sorted
	end
	
	def self.sort_by_damage_type(id)
		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		dt = Dnd5eDamageType.find(id)
		Dnd5eSpell.all.map { |m| 
					if m.damage_type and m.damage_type.split(', ').detect {|i| i == dt.name}
				      		temp = m.level.to_i 	
						@sorted[ temp ][ length[ temp ] ] = m
						length[temp] += 1 
					end
	     			   }
		@sorted
	end

	def self.sort_by_tag(ids)
		length = [0,0,0,0,0,0,0,0,0,0]
		@sorted = [[],[],[],[],[],[],[],[],[],[]]
		tags_to_search = []	
		
		ids.split(",").each do |id|
			tags_to_search << SpellTag.find(id.to_i)
		end

		Dnd5eSpell.all.map { |m|
					test = true
					tags_to_search.each do |tag| 
						if !( m.tags.split(',').detect {|i| i == tag.name} )
							test = false
						end
					end
					if test
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
