class Dnd35eClassSpell < ActiveRecord::Base
	belongs_to :Dnd35eClass
	belongs_to :Dnd35eSpell
end
