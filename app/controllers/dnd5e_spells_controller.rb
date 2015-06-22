class Dnd5eSpellsController < ApplicationController

#	caches_page :show, :index
	
	def index


		@class = nil	
		@archetype = nil
		@spell_type = nil
		@spell = nil
	
		if params[:class].to_i == 0
			@class_all = 0
		end
		
		if params[:spell_type].to_i == 0
			@spell_type_all = 0
		end

		if Dnd5eSpellType.exists?(params[:spell_type].to_i)
			@spell_type = params[:spell_type].to_i	
		end
		
		if Dnd5eClass.exists?(params[:class].to_i)
			@class = params[:class].to_i	
		end
		
		if Dnd5eSpell.exists?(params[:spell].to_i)
			@spell = params[:spell].to_i	
		end

		if Dnd5eArchetype.exists?(params[:archetype].to_i)
			@archetype = params[:archetype].to_i	
		end

		@classes = Dnd5eClass.all.sort_by &:name
		@spell_types = Dnd5eSpellType.all.sort_by &:name
		@levels = ["Cantrips", "1st-level", "2nd-level", "3rd-level", "4th-level", "5th-level", "6th-level", "7th-level", "8th-level", "9th-level"]
		
		if @class
			@archetypes = Dnd5eArchetype.get_archetypes_by_class(params[:class].to_i).sort_by &:name
		end

		if @archetype
			@spells = Dnd5eArchetypeSpell.spells_known_to_archetype_by_level(params[:archetype].to_i) 
		elsif @class
			@spells = Dnd5eClassSpell.spells_known_to_class_by_level(params[:class].to_i) 
		else
			@spells = Dnd5eSpell.sort_by_level
		end
	
		if @spell_type
			spells_of_type = Dnd5eSpellType.spells_of_certain_type_by_level(Dnd5eSpellType.find(@spell_type).name)
			for i in 0..@spells.length
                        	@spells[i] = @spells[i] & spells_of_type[i]

                        end


		end	
		
		if params[:search]
			params[:search] = params[:search].titleize.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if @best_fit = Dnd5eSpell.find_by_name(params[:search]) 
				if @spells.flatten.find { |x|  x == @best_fit }
					redirect_to :action => "index", :class => @class, :archetype => @archetype, :spell_type => @spell_type, :spell => @best_fit.id
				else
					redirect_to :action => "index", :class => @class, :spell => @spell, :spell_type => @spell_type, :archetype => @archetype
				end
			else
				if (@best_fit = Dnd5eSpell.search(params[:search])).empty?
					redirect_to :action => "index", :class => @class, :archetype => @archetype, :spell_type => @spell_type, :spell => @spell
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
		@class = nil	
		@archetype = nil
		@spell_type = nil
		if Dnd5eClass.exists?(params[:class].to_i)
			@class = params[:class].to_i	
		end

		if Dnd5eArchetype.exists?(params[:archetype].to_i)
			@archetype = params[:archetype].to_i	
		end
		
		if Dnd5eSpellType.exists?(params[:spell_type].to_i)
			@spell_type = params[:spell_type].to_i	
		end

		@spell = Dnd5eSpell.find(params[:id])
		@class_spells = Dnd5eClassSpell.classes_that_know_this_spell_by_level(@spell.id).map { |m| m = [ m.name,Dnd5eClassSpell.where(dnd5e_class_id: m.id,dnd5e_spell_id: @spell.id).take.level ] }
		@archetype_spells = Dnd5eArchetypeSpell.archetypes_that_know_this_spell_by_level(@spell.id).map { |m| m = [ m.name , Dnd5eArchetypeSpell.where(dnd5e_archetype_id: m.id,dnd5e_spell_id: @spell.id).take.level ]}
  	end

	

end
