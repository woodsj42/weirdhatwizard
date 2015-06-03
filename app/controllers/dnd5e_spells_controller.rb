class Dnd5eSpellsController < ApplicationController

	def index
		@spells = Dnd5eSpell.all
	end

	def show
    		@spell = Dnd5eSpell.find(params[:id])
  	end

end
