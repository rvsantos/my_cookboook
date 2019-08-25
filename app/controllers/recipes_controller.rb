# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_params_id, only: %i[show]
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(set_params)
    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def show; end

  private

  def set_params_id
    @recipe = Recipe.find(params[:id])
  end

  def set_params
    params.require(:recipe).permit(:title, :recipe_type, :cuisine, :difficulty,
                                    :cook_time, :ingredients, :cook_method)
  end
end
