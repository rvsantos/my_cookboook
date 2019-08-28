class Api::V1::RecipesController < Api::V1::ApiController
  before_action :set_params_id, only: %i[show]

  def show
    render json: @recipe, status: :ok
  end

  private

  def set_params_id
    @recipe = Recipe.find(params[:id])
  end
end