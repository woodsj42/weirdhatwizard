class Dnd5eRaceTrait < ActiveRecord::Base
  belongs_to :dnd5e_race
	
	def self.get_race_traits(id)
		sorted = []
		self.where(dnd5e_race_id: id).map {|m| m >> sorted }
		sorted.sort! { |a,b| a.name <=> b.name }
	end
end
