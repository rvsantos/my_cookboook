class RecipeTypesController < ApplicationController
  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
    if @recipe_type.save
      flash[:alert] = 'Tipo de receita cadastrada com sucesso'
      redirect_to new_recipe_type_path
    else
      flash.now[:alert] = 'Tipo de receita não cadastrada'
      render :new
    end
  end
end