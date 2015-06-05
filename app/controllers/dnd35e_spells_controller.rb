class Dnd35eSpellsController < ApplicationController
	
	def index
	
		@searched = []	
		
		if params[:search]
     			if !(@searched = Dnd35eSpell.search(params[:search].titleize.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the'))).empty?
				redirect_to(dnd35e_spell_path(@searched[0]))
			end
		end		
		@spells = []	
		Dnd35eSpell.all.each do |spell|
			@spells << spell	
		end
		@spells.sort_by!{ |m| m.name }	
	end	
	
	def show
    		@spell = Dnd35eSpell.find(params[:id])
  	end
end
