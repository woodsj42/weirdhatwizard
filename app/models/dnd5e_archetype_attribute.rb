class Dnd5eArchetypeAttribute < ActiveRecord::Base
	
	def self.get_all_attributes(id,level)

		@sorted = []
		self.where(dnd5e_archetype_id: id).map {|m|  if m.value != "-" and m.level.to_i <= level
						     	     	if @sorted.find { |i| if i.name == m.name 
							   			      	i = m   
										      end }
								else
									@sorted << m
								end
							     end }
		@sorted.flatten
	end
end
