class Dnd5eSubraceTrait < ActiveRecord::Base
  belongs_to :dnd5e_subrace
	def self.get_subrace_traits(id)
		sorted = []
		self.where(dnd5e_subrace_id: id).map {|m| m >> sorted }
		sorted.sort! { |a,b| a.name <=> b.name }
	end
end
