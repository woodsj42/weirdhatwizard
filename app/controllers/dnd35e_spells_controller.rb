class Dnd35eSpellsController < ApplicationController

#	caches_page :show, :index

	def index

		@domains = []
		@class_highlight = nil
		if Dnd35eClass.exists?(params[:class].to_i)
			@class_highlight = params[:class].to_i	
		end
                @levels = ["cantrips", "1st-level", "2nd-level", "3rd-level", "4th-level", "5th-level", "6th-level", "7th-level", "8th-level", "9th-level"]


=begin		
		@domain_highlight = params[:domain].to_i

		Dnd35eDomain.all.each do |domain|
			if params[:domain] and params[:domain].to_i == domain.id
				@domain_highlight = domain.id
			end 
                        @domains << domain
                end	
=end		
		
		@classes = Dnd35eClass.all

		if @class_highlight
			@spells = Dnd35eClassSpell.spells_known_to_class_by_level(params[:class].to_i)
		else
	 		@spells = Dnd35eSpell.all	
                end
			
		if params[:search]
			params[:search] = params[:search].titleize.gsub('And','and').gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if @spells.flatten.find { |x|  x == (@best_fit = Dnd35eSpell.find_by_name(params[:search])) }
                                redirect_to :controller => "dnd35e_spells", :action => "show", :id => @best_fit.id, :class => @class_highlight
			else
				if @best_fit = Dnd35eSpell.search(params[:search])
					if @class_highlight or @archetype_highlight
						for i in 0..@spells.length
							@spells[i] = @spells[i] & @best_fit 
						end
					else
							@spells = @spells & @best_fit 
					end
				else
					redirect_to :action => "index"
				end
			end
		end	
		
		if @class_highlight
			for i in 0..9
                        	if @spells[i].empty? 
                                	@levels[i] = ""
                        	end
			end
		end
end
	
	def show
                     
		@class_highlight = nil	
		if Dnd35eClass.exists?(params[:class].to_i)
			@class_highlight = params[:class].to_i	
		end

    		@spell = Dnd35eSpell.find(params[:id])
  	end
end
