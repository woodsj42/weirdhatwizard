class Dnd35eClassesController < ApplicationController
  def index
	@classes = Dnd35eClass.all
	respond_to do |format|
                        format.js
                        format.html
        end
  end
end
