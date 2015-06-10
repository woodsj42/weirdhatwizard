class Dnd5eSpell < ActiveRecord::Base

	def self.search(query)
#		where(:name query)
		where("name like ?", "%#{query}%")
	end

end
