class Dnd5eClassesController < ApplicationController
  def index
	@classes = Dnd5eClass.all
	respond_to do |format|
                        format.js
                        format.html
        end
  end
end
