class Dnd5eArchetypeAttribute < ActiveRecord::Base
	
	def self.get_all_attributes(id,level)
		sorted = []
		temp = []
		self.where(dnd5e_archetype_id: id).map {|m|  if m.level.to_i <= level.to_i
                                                                        temp << m 
	    						 end }
		temp.sort! {|a,b| b.level.to_i <=> a.level.to_i}
		temp.each do |i|
			there = true
			sorted.each do |j|
				if j.name == i.name
					there = false	 
				end
			end
			if there
				sorted << i 
			end
		end
		sorted	
	end
	
	def self.get_attributes(id,level)
		sorted = []
		temp1 = []
		temp2 = [] 
		if level.to_i == 1
			temp1 = Dnd5eArchetypeAttribute.get_all_attributes(id, level)
			temp1.each do |a|
				sorted << ["*&nbsp;", a]
			end
		else
			temp1 = Dnd5eArchetypeAttribute.get_all_attributes(id, (level.to_i-1).to_s)
			temp2 = Dnd5eArchetypeAttribute.get_all_attributes(id, level)

			temp2.each do |a|
				newer = false
				brand_new = false
				old = false
				temp1.each do |b|
					if a.name == b.name
						if b.value != a.value or b.description != a.description 
							newer = true
						else
							old = true
						end
					end
				end 			
					if newer or !( old or newer )
						sorted << ["*&nbsp;", a] 
					elsif old 
						sorted << ["&nbsp;&nbsp;", a] 
						
					end
			end
		end
			sorted
	end
end
