class Dnd5eArchetype < ActiveRecord::Base

	has_many :Dnd5eArchetypeSpells
	has_many :Dnd5eSpells, :through => :Dnd5eSpells
end
