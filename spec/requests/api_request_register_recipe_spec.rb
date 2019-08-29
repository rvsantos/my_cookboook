require 'rails_helper'

describe 'API resquest register recipe' do
  it 'and return json' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = { title: 'Bolo de Cara', recipe_type_id: recipe_type.id,
                cuisine_id: cuisine.id, difficulty: 'facíl', cook_time: 40,
                ingredients: 'farinha, ovo, cara, leite, açucar',
                cook_method: 'mistura e bate tudo', user_id: user.id }

    post '/api/v1/recipes', params: { recipe: recipe }

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201
    expect(json_recipe[:title]).to eq recipe[:title]
  end

  it 'and fail' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = { recipe_type_id: recipe_type.id,
                cuisine_id: cuisine.id, difficulty: 'facíl', cook_time: 40,
                ingredients: 'farinha, ovo, cara, leite, açucar',
                cook_method: 'mistura e bate tudo', user_id: user.id }

    post '/api/v1/recipes', params: { recipe: recipe }

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 412
    # expect(json_recipe[:title]).to eq recipe[:title]
  end

  it 'and delete recipe' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, user: user,
                    cuisine: cuisine)

    delete "/api/v1/recipes/#{recipe.id}"

    expect(response.status).to eq 202
    # expect(json_recipe[:title]).to eq recipe[:title]
  end

  it 'and delete recipe fails' do
    delete "/api/v1/recipes/000"

    expect(response.status).to eq 404
    expect(response.body).to include('Receita deletada com sucesso')
  end
end