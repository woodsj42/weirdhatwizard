class Dnd35eSpell < ActiveRecord::Base

	has_many :Dnd35eClassSpells
	has_many :Dnd35eClasses, :through => :Dnd35eClassSpells	

	def self.search(query)
#		where(:name query)
		where("name like ?", "%#{query}%")
	end
end
