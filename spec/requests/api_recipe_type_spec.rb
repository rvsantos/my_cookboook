require 'rails_helper'

describe 'View recipe for type' do
  it 'and return json' do
    user = create(:user)
    cuisine = create(:cuisine)
    recipe_type = RecipeType.create(name: 'Chinesa')
    other_recipe_type = RecipeType.create(name: 'Jamaicana')
    recipe = create(:recipe, title: 'Tutu de feijão', recipe_type: other_recipe_type, user: user, cuisine: cuisine, status: 0)
    other_recipe = create(:recipe, title: 'Carnes', recipe_type: other_recipe_type, user: user, cuisine: cuisine, status: 0)
    not_appear_recipe = create(:recipe, title: 'Comida Vegana', recipe_type: recipe_type, user: user, cuisine: cuisine, status: 0)

    get api_v1_recipe_type_path(other_recipe_type)

    json_recipe_type = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    expect(json_recipe_type.to_s).to  include(recipe.title)
    expect(json_recipe_type.to_s).to  include(other_recipe.title)
    expect(json_recipe_type.to_s).to_not  include(not_appear_recipe.title)
  end

  it 'and register new type of recipes' do
    post api_v1_recipe_types(name: 'Chinesa')

    expect(response.status).to eq 201
  end
end