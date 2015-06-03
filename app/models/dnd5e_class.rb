class Dnd5eClass < ActiveRecord::Base

	has_many :Dnd5eArchetypes
	has_many :Dnd5eClassSpells
	has_many :Dnd5eSpells, :through => :Dnd5eClassSpells
end
