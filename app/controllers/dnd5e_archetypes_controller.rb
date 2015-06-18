class Dnd5eArchetypesController < ApplicationController
  def index
	@archetypes = Dnd5eArchetype.all
	respond_to do |format|
                        format.js
                        format.html
        end
  end
end
