class Api::V1::RecipesController < Api::V1::ApiController
  # before_action :set_params_id, only: %i[show]

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe, status: 200
  end

  def create
    recipe = Recipe.new(set_params)

    if recipe.save
      render json: recipe, status: 201
    else
      render json: { errors: recipe.errors.full_messages }, status: 412
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    render json: {}, status: 202

  rescue ActiveRecord::RecordNotFound
    render json: { msg: 'Receita deletada com sucesso' }, status: 404
  end

  private

  def set_params_id
    @recipe = Recipe.find(params[:id])
  end

  def set_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                    :cook_time, :ingredients, :cook_method, :user_id)
  end
end