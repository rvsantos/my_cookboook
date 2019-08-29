# frozen_string_literal: true

class Api::V1::RecipeTypesController < Api::V1::ApiController
  # before_action :set_params_id, only: %i[show]

  def show
    recipe_type = RecipeType.find(params[:id])
    render json: recipe_type.recipes, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { msg: 'Tipo de receita não cadastrada' }, status: 404
  end

  def create
    recipe_type = RecipeType.new(set_params)

    if recipe_type.save
      render json: recipe_type, status: 201
    else
      render json: { errors: recipe_type.errors.full_messages }, status: 412
    end
  end

  private

  def set_params_id
    recipe_type = RecipeType.find(params[:id])
  end

  def set_params
    params.require(:recipe_type).permit(:name)
  end
end
