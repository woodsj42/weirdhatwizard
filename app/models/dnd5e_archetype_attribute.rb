class Dnd5eArchetypeAttribute < ActiveRecord::Base
	
	def self.get_all_attributes(id,level)
		@sorted = []
		temp = []
		self.where(dnd5e_archetype_id: id).map {|m|  if m.value != "-" and m.level.to_i <= level
                                                                        temp << m 
	    						 end }
		temp.sort! {|a,b| a.name <=> b.name}
		max = temp[0]
		for i in 1..temp.length-1
			if max.name != temp[i].name
				@sorted << max
				max = temp[i]
			elsif
				if max.level.to_i < temp[i].level.to_i
					max = temp[i]
				end	
			end	
		end
		@sorted.sort! {|a,b| a.level.to_i <=> b.level.to_i}
	end
end
