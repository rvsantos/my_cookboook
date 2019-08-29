require 'rails_helper'

describe 'View recipes by type' do
  it 'and return json' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = RecipeType.create(name: 'Chinesa')
    other_recipe_type = RecipeType.create(name: 'Jamaicana')
    recipe = create(:recipe, title: 'Tutu de feijão', recipe_type: other_recipe_type, user: user, cuisine: cuisine, status: 0)
    other_recipe = create(:recipe, title: 'Carnes', recipe_type: other_recipe_type, user: user, cuisine: cuisine, status: 0)
    not_appear_recipe = create(:recipe, title: 'Comida Vegana', recipe_type: recipe_type, user: user, cuisine: cuisine, status: 0)

    get "/api/v1/recipe_types/#{other_recipe_type.id}"
    # get api_v1_recipe_type_path(other_recipe_type)

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    expect(json_recipe_type.to_s).to  include(recipe.title)
    expect(json_recipe_type.to_s).to  include(other_recipe.title)
    expect(json_recipe_type.to_s).to_not include(not_appear_recipe.title)
  end

  it 'and return error' do
    get "/api/v1/recipe_types/000"

    expect(response.status).to eq 404
    expect(response.body).to include('Tipo de receita não cadastrada')
  end

  it 'and register recipe types' do
    post '/api/v1/recipe_types', params: { recipe_type: { name: 'Sobremesa' } }

    expect(response.status).to eq 201
    expect(response.body).to include('Sobremesa')
  end

  it 'and register recipe types and fails' do
    post '/api/v1/recipe_types', params: { recipe_type: { name: "" } }

    expect(response.status).to eq 412
    # expect(response.body).to include('Campo obrigatorio')
  end
end