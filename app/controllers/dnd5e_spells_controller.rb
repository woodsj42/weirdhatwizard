class Dnd5eSpellsController < ApplicationController

#	caches_page :show, :index

	def index


		@class_highlight = nil	
		@archetype_highlight = nil
		if Dnd5eClass.exists?(params[:class].to_i)
			@class_highlight = params[:class].to_i	
		end

		if Dnd5eArchetype.exists?(params[:archetype].to_i)
			@archetype_highlight = params[:archetype].to_i	
		end

		@archetypes = []
		@levels = ["Cantrips", "1st-level", "2nd-level", "3rd-level", "4th-level", "5th-level", "6th-level", "7th-level", "8th-level", "9th-level"]
		
		if @class_highlight
			@archetypes = Dnd5eArchetype.get_archetypes_by_class(params[:class].to_i)
		end

		if @archetype_highlight
			@spells = Dnd5eArchetypeSpell.spells_known_to_archetype_by_level(params[:archetype].to_i) 
		elsif @class_highlight
			@spells = Dnd5eClassSpell.spells_known_to_class_by_level(params[:class].to_i) 
		else
			@spells = Dnd5eSpell.sort_by_level
		end
			
		if params[:search]
			params[:search] = params[:search].titleize.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if @best_fit = Dnd5eSpell.find_by_name(params[:search])
					redirect_to(dnd5e_spell_path(@best_fit))
			else
				if @best_fit = Dnd5eSpell.search(params[:search])
					for i in 0..@spells.length
						@spells[i] = @spells[i] & @best_fit 
					end
				else
					redirect_to :action => "index"
				end
			end
		end
			
		for i in 0..9
			if @spells[i].empty? 
				@levels[i] = ""
			end
		end
	end

	def show
    		@spell = Dnd5eSpell.find(params[:id])
  	end

	

end
