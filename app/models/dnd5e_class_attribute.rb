class Dnd5eClassAttribute < ActiveRecord::Base


	def self.get_attributes(id,level)

		@sorted = []
		self.where(dnd5e_class_id: id, level: level ).map {|m|  if m.value != "-" 
									   @sorted << [ m.name,m.value ]
									end }
		@sorted.reverse!
	end
end
