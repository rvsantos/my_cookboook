require 'rails_helper'

describe 'View recipe details' do
  it 'and return json' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, recipe_type: recipe_type, user: user, cuisine: cuisine, status: 0)

    # get "/api/v1/recipes/#{recipe.id}"
    get api_v1_recipe_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    expect(json_recipe[:title]).to eq recipe.title
  end
end