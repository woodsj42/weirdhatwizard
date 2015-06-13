class Dnd35eClass < ActiveRecord::Base

	has_many :dnd35e_class_spells
	has_many :dnd35e_spells, :through => :dnd35e_class_spells	

end
