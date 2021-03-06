class Dnd35eSpellsController < ApplicationController

#	caches_page :show, :index

	def index


		@domains = []

		if params[:class].to_i == 0
			@all = 0
		end

		@class = nil
		@spell = nil
		@spell_type = nil
		@search = params[:search]
	
	
		if params[:class].to_i == 0
                        @class_all = 0
                end
		if params[:spell_type].to_i == 0
                        @spell_type_all = 0
                end

		if Dnd5eSpellType.exists?(params[:spell_type].to_i)
                        @spell_type = params[:spell_type].to_i
                end

		if Dnd35eClass.exists?(params[:class].to_i)
			@class = params[:class].to_i	
		end
		if Dnd35eSpell.exists?(params[:spell].to_i)
			@spell = params[:spell].to_i	
		end
		@spell_types = Dnd5eSpellType.all.sort_by &:name
                @levels = ["cantrips", "1st-level", "2nd-level", "3rd-level", "4th-level", "5th-level", "6th-level", "7th-level", "8th-level", "9th-level"]

                    
=begin		
		@domain = params[:domain].to_i

		Dnd35eDomain.all.each do |domain|
			if params[:domain] and params[:domain].to_i == domain.id
				@domain = domain.id
			end 
                        @domains << domain
                end	
=end		
		
		@classes = Dnd35eClass.all
		if @class
			@spells = Dnd35eClassSpell.spells_known_to_class_by_level(params[:class].to_i)
			if @spell_type
                        	spells_of_type = Dnd5eSpellType.spells_of_certain_type_by_level_dnd35e(Dnd5eSpellType.find(@spell_type).name)
                        	for i in 0..@spells.length-1
                                	@spells[i] = @spells[i] & spells_of_type
				end
			end
		else
	 		@spells = Dnd35eSpell.all 
	 		if @spell_type
				@spells = @spells & Dnd5eSpellType.spells_of_certain_type_by_level_dnd35e(Dnd5eSpellType.find(@spell_type).name)
                	end
		end
			
		if @search
			@search = @search.titleize.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if @best_fit = Dnd35eSpell.find_by_name(@search)
				if @spells.flatten.find { |x|  x == @best_fit }
                                	redirect_to :controller => "dnd35e_spells", :action => "index", :spell => @best_fit.id, :class => @class, :spell_type => @spell_type
				else
					redirect_to :action => "index", :class => @class, :spell => @spell, :spell_type => @spell_type
				end
			else
				@best_fit = Dnd35eSpell.search(@search)
				
				if @class or @archetype
					for i in 0..@spells.length-1
						@spells[i] = @spells[i] & @best_fit 
					end
				else
					@spells = @spells & @best_fit 
				end

				if @spells.flatten.empty?
					redirect_to :action => "index", :class => @class, :spell => @spell, :spell_type => @spell_type
				elsif @spells.flatten.length == 1
					redirect_to :action => "index", :class => @class, :spell => @spells.flatten.first, :spell_type => @spell_type
				end
			end
		end	
		
		if @class
			for i in 0..9
                        	if @spells[i].empty? 
                                	@levels[i] = ""
                        	end
			end
		end
end
	
	def show
                     
		@class = nil	
		if Dnd35eClass.exists?(params[:class].to_i)
			@class = params[:class].to_i	
		end

    		@spell = Dnd35eSpell.find(params[:id])
  	end
end
