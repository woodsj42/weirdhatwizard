class Dnd5eSpell < ActiveRecord::Base
	
	has_many :dnd5e_class_spells
	has_many :dnd5e_classes, :through => :dnd5e_class_spells	

	def self.search(query)
#		where(:name query)
		where("name like ?", "%#{query}%")
	end

end
