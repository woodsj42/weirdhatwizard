class Dnd5eClass < ActiveRecord::Base
	
	has_many :dnd5e_class_spells
	has_many :dnd5e_spells, :through => :dnd5e_class_spells	
	
end
