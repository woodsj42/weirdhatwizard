class Dnd5eSpell < ActiveRecord::Base

	has_many :Dnd5eArchetypeSpells
	has_many :Dnd5eClassSpells
	has_many :Dnd5eClasses, :through => :Dnd5eClassSpells	
	has_many :Dnd5eArchetypes, :through => :Dnd5eArchetypeSpells	

end
