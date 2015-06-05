class Dnd35eClass < ActiveRecord::Base
	
	has_many :Dnd35eClassSpells
	has_many :Dnd35eSpells, :through => :Dnd35eClassSpells
end
