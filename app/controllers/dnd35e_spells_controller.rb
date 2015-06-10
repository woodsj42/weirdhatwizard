class Dnd35eSpellsController < ApplicationController

#	caches_page :show, :index

	def index

		@domains = []
		@classes = []
		@class_highlight = params[:class].to_i
#		@domain_highlight = params[:domain].to_i

=begin		
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
		
		Dnd35eClass.all.each do |c|
			@classes << c
		end

		@spells = []
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
                       
			if params[:class]
                      
		  		Dnd35eClassSpell.spells_known_to_class(params[:class]).map { |m|
                                	        case Dnd35eClassSpell.where(:dnd35e_spell_id => m.id, :dnd35e_class_id => params[:class].to_i ).take.level.to_i        
                                        	        when 0
                                                	        @level0spells << m      
                       	        	                when 1
                         	        	                @level1spells << m      
                                    	            	when 2
                                                        	@level2spells << m      
                                                	when 3
                                                        	@level3spells << m      
                                                	when 4
                                                        	@level4spells << m      
                                                	when 5
                                                        	@level5spells << m      
                                                	when 6
                                                        	@level6spells << m      
                                                	when 7
                                                        	@level7spells << m      
                                                	when 8
                                                        	@level8spells << m      
                                                	when 9
                                                        	@level9spells << m      
                                        	end
                        	}
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
 
			else
		
				Dnd5eSpell.all.map { |m| @spells << m }
				@spells.sort_by!{ |m| m.name }	

                	end
			@classes.sort_by!{ |m| m.name }
#			raise @level0spells.map { |m| m = m.name }.inspect
end
	
	def show
    		@spell = Dnd35eSpell.find(params[:id])
  	end
end
