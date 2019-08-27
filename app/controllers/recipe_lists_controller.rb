class RecipeListsController < ApplicationController
  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(params.require(:recipe_list).permit(:name))
    @recipe_list.user = current_user
    if @recipe_list.save
      flash[:alert] = 'Lista criada com sucesso'
      redirect_to @recipe_list
    else
      flash.now[:alert] = 'Já possui uma lista com este nome'
      render :new
    end
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
  end

  def my_list
    @recipe_lists = current_user.recipe_lists
    @recipe_list_items = current_user.recipe_list_item
  end

end