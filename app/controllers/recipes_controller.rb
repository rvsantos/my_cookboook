# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_params_id, only: %i[show]
  def index
    @recipes = Recipe.all
  end

  def show; end

  private

  def set_params_id
    @recipe = Recipe.find(params[:id])
  end
end
