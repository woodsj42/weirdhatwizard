class Dnd35eDomain < ActiveRecord::Base
	
	has_many :dnd35e_domain_spells
	has_many :dnd35e_spells, :through => :dnd35e_domain_spells	
end
