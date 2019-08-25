require 'rails_helper'

feature 'visitor search recipes' do
  scenario 'successfully' do
    cuisine = Cuisine.create(name: 'Indigena')
    recipe_type = RecipeType.create(name: 'Café da manhã')
    Recipe.create(title: 'Bolo de Cara', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')
    Recipe.create(title: 'Pastel de Goiabada', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')

    visit root_path
    fill_in "Buscar",	with: "Pastel de Goiabada"
     click_on 'Buscar'

     expect(page).to have_css('h3', text: 'Pastel de Goiabada')
  end

  scenario 'and search recipe for exact name and fail' do
    cuisine = Cuisine.create(name: 'Indigena')
    recipe_type = RecipeType.create(name: 'Café da manhã')
    Recipe.create(title: 'Bolo de Cara', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')
    Recipe.create(title: 'Pastel de Goiabada', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')

    visit root_path
    fill_in "Buscar",	with: "Pastel de Abobora"
     click_on 'Buscar'

     expect(page).to have_css('h3', text: 'Receita não encontrada')
  end

  scenario 'and search recipe for partial name' do
    cuisine = Cuisine.create(name: 'Indigena')
    recipe_type = RecipeType.create(name: 'Café da manhã')
    Recipe.create(title: 'Bolo de Cara', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')
    Recipe.create(title: 'Pastel de Goiabada', recipe_type: recipe_type,
                          cuisine: cuisine, difficulty: 'facíl', cook_time: 40,
                          ingredients: 'farinha, ovo, cara, leite, açucar',
                          cook_method: 'mistura e bate tudo')

    visit root_path
    fill_in "Buscar",	with: "Bolo"
     click_on 'Buscar'

     expect(page).to have_css('h3', text: 'Bolo de Cara')
  end
end