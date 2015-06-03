class Dnd5eClassSpell < ActiveRecord::Base

	belongs_to :Dnd5eClass
	belongs_to :Dnd5eSpell

end
