class Api::V1::RecipeTypesController < Api::V1::ApiController
  before_action :set_params_id, only: %i[show]

  def show
    render json: @recipe_type.recipes, status: :ok
  end

  private

  def set_params_id
    @recipe_type = RecipeType.find(params[:id])
  end
end