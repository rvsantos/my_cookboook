# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_params_id, only: %i[edit update show]
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

  def show; end

  def search
    @recipe = Recipe.where('title LIKE ?', "%#{params[:name]}%")
  end

  def list; end

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
