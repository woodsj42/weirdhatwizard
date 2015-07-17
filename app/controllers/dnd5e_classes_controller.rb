class Dnd5eClassesController < ApplicationController
  def index
	
	@class = nil
        @archetype = nil
	@level = nil 
	@a_attr = nil 
	@c_attr = nil 

	if params[:level].to_i > 0 and params[:level].to_i < 21
        	@level = params[:level].to_i
        end
	

	if Dnd5eClassAttribute.exists?(params[:c_attr].to_i)
                        @c_attr = params[:c_attr].to_i
        end
	
	if Dnd5eArchetypeAttribute.exists?(params[:a_attr].to_i)
                        @a_attr = params[:a_attr].to_i
        end

	if Dnd5eClass.exists?(params[:class].to_i)
                        @class = params[:class].to_i
        end

	if Dnd5eArchetype.exists?(params[:archetype].to_i)
        	@archetype = params[:archetype].to_i
        end


	@classes = Dnd5eClass.all.sort_by &:name
	@levels = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th" ]
        
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

  end
end
