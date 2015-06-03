class Dnd5eSpellsController < ApplicationController

	def index
		@spells = Dnd5eSpell.all
		@level0spells = []	
		@level1spells = []	
		@level2spells = []	
		@level3spells = []	
		@level4spells = []	
		@level5spells = []	
		@level6spells = []	
		@level7spells = []	
		@level8spells = []	
		@level9spells = []	
		Dnd5eSpell.all.each do |spell|
			case spell.level.downcase 
			when "cantrip"
				@level0spells << spell	
			when "1st-level"
				@level1spells << spell	
			when "2nd-level"
				@level2spells << spell	
			when "3rd-level"
				@level3spells << spell	
			when "4th-level"
				@level4spells << spell	
			when "5th-level"
				@level5spells << spell	
			when "6th-level"
				@level6spells << spell	
			when "7th-level"
				@level7spells << spell	
			when "8th-level"
				@level8spells << spell	
			when "9th-level"
				@level9spells << spell	
			end
		end
		@level0spells.sort_by!{ |m| m.name }	
		@level1spells.sort_by!{ |m| m.name }	
		@level2spells.sort_by!{ |m| m.name }	
		@level3spells.sort_by!{ |m| m.name }	
		@level4spells.sort_by!{ |m| m.name }	
		@level5spells.sort_by!{ |m| m.name }	
		@level6spells.sort_by!{ |m| m.name }	
		@level7spells.sort_by!{ |m| m.name }	
		@level8spells.sort_by!{ |m| m.name }	
		@level9spells.sort_by!{ |m| m.name }	
			
	end

	def show
    		@spell = Dnd5eSpell.find(params[:id])
  	end

end
