# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_params_id, only: %i[edit update show add_list]
  before_action :set_recipe_types_and_cuisines, only: %i[edit update new create]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(set_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = 'Não foi possível salvar a receita'
      render :new
    end
  end

  def edit; end

  def update
    if @recipe.update(set_params)
      redirect_to @recipe
    else
      flash.now[:alert] = 'Não foi possível salvar a receita'
      render :edit
    end
  end

  def show
    if current_user
      @recipe_list = current_user.recipe_lists
    end
  end

  def search
    @recipe = Recipe.where('title LIKE ?', "%#{params[:name]}%")
  end

  def my_recipes
    @recipes = current_user.recipes
  end

  def add_list
    @recipe_list = RecipeList.find(params[:id])
    @recipe_list_item = RecipeListItem.new(recipe_id: @recipe.id,
                                            recipe_list_id: @recipe_list.id)
    if @recipe_list_item.save
      flash[:notice] = 'Receita adicionada com sucesso'
      redirect_to @recipe
    else
      flash[:alert] = 'Esta receita já esta incluida nesta lista'
      render :show
    end
  end

  def list_pending
    @recipes = Recipe.pending
  end

  def published
    current_user.recipes.find(params[:id]).published!
    # @recipe.published!
    # current_user.recipes.status.published!
    flash[:notice] = 'Receita publicada com sucesso'
    redirect_to :list_pending
  end

  private

  def set_params_id
    @recipe = Recipe.find(params[:id])
  end

  def set_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                    :cook_time, :ingredients, :cook_method, :user_id)
  end

  def set_recipe_types_and_cuisines
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end
end
