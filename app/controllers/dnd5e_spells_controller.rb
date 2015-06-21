class Dnd5eSpellsController < ApplicationController

#	caches_page :show, :index

	def index


		@class_highlight = nil	
		@archetype_highlight = nil
		@spell_type_highlight = nil
	
		if params[:class].to_i == 0
			@class_all = 0
		end
		
		if params[:spell_type].to_i == 0
			@spell_type_all = 0
		end

		if Dnd5eSpellType.exists?(params[:spell_type].to_i)
			@spell_type_highlight = params[:spell_type].to_i	
		end
		
		if Dnd5eClass.exists?(params[:class].to_i)
			@class_highlight = params[:class].to_i	
		end

		if Dnd5eArchetype.exists?(params[:archetype].to_i)
			@archetype_highlight = params[:archetype].to_i	
		end

		@classes = Dnd5eClass.all.sort_by &:name
		@spell_types = Dnd5eSpellType.all.sort_by &:name
		@levels = ["Cantrips", "1st-level", "2nd-level", "3rd-level", "4th-level", "5th-level", "6th-level", "7th-level", "8th-level", "9th-level"]
		
		if @class_highlight
			@archetypes = Dnd5eArchetype.get_archetypes_by_class(params[:class].to_i).sort_by &:name
		end

		if @archetype_highlight
			@spells = Dnd5eArchetypeSpell.spells_known_to_archetype_by_level(params[:archetype].to_i) 
		elsif @class_highlight
			@spells = Dnd5eClassSpell.spells_known_to_class_by_level(params[:class].to_i) 
		else
			@spells = Dnd5eSpell.sort_by_level
		end
	
		if @spell_type_highlight
			spells_of_type = Dnd5eSpellType.spells_of_certain_type_by_level(Dnd5eSpellType.find(@spell_type_highlight).name)
			for i in 0..@spells.length
                        	@spells[i] = @spells[i] & spells_of_type[i]

                        end


		end	
		
		if params[:search]
			params[:search] = params[:search].titleize.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if @spells.flatten.find { |x|  x == (@best_fit = Dnd5eSpell.find_by_name(params[:search])) }  
				redirect_to :controller => "dnd5e_spells", :action => "show", :id => @best_fit.id, :class => @class_highlight, :archetype => @archetype_highlight, :spell_type => @spell_type_highlight
			else
				if (@best_fit = Dnd5eSpell.search(params[:search])).empty?
					redirect_to :action => "index", :class => @class_highlight, :archetype => @archetype_highlight, :spell_type => @spell_type_highlight
				else
					for i in 0..@spells.length
						@spells[i] = @spells[i] & @best_fit 
					end
				end
			end
		end
			
		for i in 0..9
			if @spells[i].empty? 
				@levels[i] = ""
			else
				@spells[i].sort! {|a,b| a.name <=> b.name }
			end
		end
	end

	def show
		@class_highlight = nil	
		@archetype_highlight = nil
		@spell_type_highlight = nil
		if Dnd5eClass.exists?(params[:class].to_i)
			@class_highlight = params[:class].to_i	
		end

		if Dnd5eArchetype.exists?(params[:archetype].to_i)
			@archetype_highlight = params[:archetype].to_i	
		end
		
		if Dnd5eSpellType.exists?(params[:spell_type].to_i)
			@spell_type_highlight = params[:spell_type].to_i	
		end

		@spell = Dnd5eSpell.find(params[:id])
		@class_spells = Dnd5eClassSpell.classes_that_know_this_spell_by_level(@spell.id).map { |m| m = [ m.name,Dnd5eClassSpell.where(dnd5e_class_id: m.id,dnd5e_spell_id: @spell.id).take.level ] }
		@archetype_spells = Dnd5eArchetypeSpell.archetypes_that_know_this_spell_by_level(@spell.id).map { |m| m = [ m.name , Dnd5eArchetypeSpell.where(dnd5e_archetype_id: m.id,dnd5e_spell_id: @spell.id).take.level ]}
  	end

	

end
