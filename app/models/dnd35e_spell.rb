class Dnd35eSpell < ActiveRecord::Base
	
	has_many :dnd35e_class_spells
	has_many :dnd35e_classes, :through => :dnd35e_class_spells	
	has_many :dnd35e_domain_spells
	has_many :dnd35e_domains, :through => :dnd35e_domain_spells	
	
	def self.search(query)
#		where(:name query)
		where("name like ?", "%#{query}%")
	end
end
