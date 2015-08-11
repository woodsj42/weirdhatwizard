class Dnd5eClassesController < ApplicationController
  def index
	
	@class = nil
        @archetype = nil
	@level = nil
	@race = nil
	@subrace = nil 
	@a_attr = nil 
	@c_attr = nil 
	@r_trait = nil 
	@s_trait = nil 

	if params[:level].to_i > 0 and params[:level].to_i < 21
        	@level = params[:level].to_i
        end
	
	if Dnd5eSubraceTrait.exists?(params[:s_trait].to_i)
                        @s_trait = params[:s_trait].to_i
        end

	if Dnd5eRaceTrait.exists?(params[:r_trait].to_i)
                        @r_trait = params[:r_trait].to_i
        end

	if Dnd5eClassAttribute.exists?(params[:c_attr].to_i)
                        @c_attr = params[:c_attr].to_i
        end
	
	if Dnd5eArchetypeAttribute.exists?(params[:a_attr].to_i)
                        @a_attr = params[:a_attr].to_i
        end

	if Dnd5eRace.exists?(params[:race].to_i)
                        @race = params[:race].to_i
        end

	if Dnd5eSubrace.exists?(params[:subrace].to_i)
                        @subrace = params[:subrace].to_i
        end

	if Dnd5eClass.exists?(params[:class].to_i)
                        @class = params[:class].to_i
        end

	if Dnd5eArchetype.exists?(params[:archetype].to_i)
        	@archetype = params[:archetype].to_i
        end


	@classes = Dnd5eClass.all.sort_by &:name
	@levels = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th" ]
	@races = Dnd5eRace.all.sort_by &:name      
	@race_traits = []
	@subrace_traits = []
	@ability_scores = []	
 
	if @class
        	@archetypes = Dnd5eArchetype.get_archetypes_by_class(params[:class].to_i).sort_by &:name
        end
	
	@a_d_attr = []
	@a_n_attr = []
	@c_d_attr = []
	@c_n_attr = []
	

	if @level and @archetype
		Dnd5eArchetypeAttribute.get_attributes(@archetype,@level).map {|m| if m[1].value == '*'
											       		@a_n_attr << m
											       else
												  	@a_d_attr << m
											       end}
	end
	
	if @level and @class
		Dnd5eClassAttribute.get_attributes(@class,@level).map {|m| if m[1].value == '*'
										    	@c_n_attr << m
									            else
									            	@c_d_attr << m
									            end} 
	end
	

	if @race
		@race_traits = Dnd5eRaceTrait.where( dnd5e_race_id: @race.to_i )
		@subraces = Dnd5eSubrace.where( dnd5e_race_id: @race.to_i ).sort_by &:name     
		@ability_scores << [ "Strength",     Dnd5eRace.find(@race).str.to_i ]
		@ability_scores << [ "Dexterity",    Dnd5eRace.find(@race).dex.to_i ] 
		@ability_scores << [ "Constitution", Dnd5eRace.find(@race).con.to_i ]
		@ability_scores << [ "Intelligence", Dnd5eRace.find(@race).int.to_i ]
		@ability_scores << [ "Wisdom",       Dnd5eRace.find(@race).wis.to_i ]
		@ability_scores << [ "Charisma",     Dnd5eRace.find(@race).cha.to_i ]
	end

	if @subrace
		@subrace_traits = Dnd5eSubraceTrait.where( dnd5e_subrace_id: @subrace.to_i )
		@ability_scores[0][1] += Dnd5eSubrace.find(@subrace).str.to_i 
		@ability_scores[1][1] += Dnd5eSubrace.find(@subrace).dex.to_i 
		@ability_scores[2][1] += Dnd5eSubrace.find(@subrace).con.to_i 
		@ability_scores[3][1] += Dnd5eSubrace.find(@subrace).int.to_i 
		@ability_scores[4][1] += Dnd5eSubrace.find(@subrace).wis.to_i 
		@ability_scores[5][1] += Dnd5eSubrace.find(@subrace).cha.to_i 
	end

  end
end
