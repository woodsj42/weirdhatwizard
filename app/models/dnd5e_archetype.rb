class Dnd5eArchetype < ActiveRecord::Base
	
	has_many :dnd5e_archetype_spells
	has_many :dnd5e_spells, :through => :dnd5e_archetype_spells	
end
