class Dnd5eArchetypeSpell < ActiveRecord::Base

	belongs_to :Dnd5eArchetype
	belongs_to :Dnd5eSpell

end
