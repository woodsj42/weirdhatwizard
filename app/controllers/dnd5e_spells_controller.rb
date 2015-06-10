class Dnd5eSpellsController < ApplicationController

#	caches_page :show, :index

	def index

		@archetypes = []	
		@class_highlight = params[:class].to_i	
		@archetype_highlight = params[:archetype].to_i


		
		if params[:search]
			params[:search] = params[:search].titleize.gsub('Of', 'of').gsub('With','with').gsub('Into','into').gsub('The', 'the')
			if Dnd5eSpell.exists?(name: params[:search])
				@best_fit = Dnd5eSpell.find_by_name(params[:search])
			else
				@best_fit = Dnd5eSpell.search(params[:search])[0]
			end
				if @best_fit.nil?
					redirect_to :action => "index"
				else
					redirect_to(dnd5e_spell_path(@best_fit))
				end
		end		
		
		if params[:class]
				
			Dnd5eArchetype.all.each do |archetype|
				if @class_highlight == archetype.dnd5e_class_id
                        		@archetypes << archetype
				end
                	end
		end


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

		if params[:archetype]

			
			Dnd5eArchetypeSpell.spells_known_to_archetype(params[:archetype]).map { |m| 
					case m.level.downcase		
						when "cantrip"
							@level0spells << m	
						when "1st-level"
							@level1spells << m	
						when "2nd-level"
							@level2spells << m	
						when "3rd-level"
							@level3spells << m	
						when "4th-level"
							@level4spells << m	
						when "5th-level"
							@level5spells << m	
						when "6th-level"
							@level6spells << m	
						when "7th-level"
							@level7spells << m	
						when "8th-level"
							@level8spells << m	
						when "9th-level"
							@level9spells << m	
					end
			}
				
		elsif params[:class]
					
			Dnd5eClassSpell.spells_known_to_class(params[:class]).map { |m| 
					case m.level.downcase		
						when "cantrip"
							@level0spells << m	
						when "1st-level"
							@level1spells << m	
						when "2nd-level"
							@level2spells << m	
						when "3rd-level"
							@level3spells << m	
						when "4th-level"
							@level4spells << m	
						when "5th-level"
							@level5spells << m	
						when "6th-level"
							@level6spells << m	
						when "7th-level"
							@level7spells << m	
						when "8th-level"
							@level8spells << m	
						when "9th-level"
							@level9spells << m	
					end
			}
		else
		
			Dnd5eSpell.all.map { |m| 
					case m.level.downcase		
						when "cantrip"
							@level0spells << m	
						when "1st-level"
							@level1spells << m	
						when "2nd-level"
							@level2spells << m	
						when "3rd-level"
							@level3spells << m	
						when "4th-level"
							@level4spells << m	
						when "5th-level"
							@level5spells << m	
						when "6th-level"
							@level6spells << m	
						when "7th-level"
							@level7spells << m	
						when "8th-level"
							@level8spells << m	
						when "9th-level"
							@level9spells << m	
					end
			}

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
