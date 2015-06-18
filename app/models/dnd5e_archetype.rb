class Dnd5eArchetype < ActiveRecord::Base
	
	belongs_to :dnd5e_class
	has_many :dnd5e_archetype_spells
	has_many :dnd5e_spells, :through => :dnd5e_archetype_spells	


	def self.get_archetypes_by_class(id)
		where(dnd5e_class_id: id).all
	end        
end
