class Dnd35eSpellsController < ApplicationController

#	caches_page :show, :index

	def index

		@domains = []
		@class_highlight = params[:class].to_i
		@spells = [[],[],[],[],[],[],[],[],[],[]]
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
		if params[:search]
			params[:search] = params[:search].titleize.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd35eSpell.exists?(name: params[:search])
				@best_fit = Dnd35eSpell.find_by_name(params[:search])
			else
				@best_fit = Dnd35eSpell.search(params[:search])[0]
			end
				if @best_fit.nil?
					redirect_to :action => "index"
				else
					redirect_to(dnd35e_spell_path(@best_fit))
				end
		end	
		
		@classes = Dnd35eClass.all

		@spells = []
			if params[:class]
				@spells = Dnd35eClassSpell.spells_known_to_class_by_level(params[:class].to_i)
			else
	 			@spells = Dnd35eSpell.all	
                	end
		
		if params[:class]	
			for i in 0..9
                        	if @spells[i].empty? 
                                	@levels[i] = ""
                        	end
			end
		end

end
	
	def show
    		@spell = Dnd35eSpell.find(params[:id])
  	end
end
