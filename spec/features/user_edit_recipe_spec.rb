require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    user = create(:user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    cuisine = Cuisine.create(name: 'Brasilera')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio', user: user,
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    login_as user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasilera')
    Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio', user: user,
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    # simula a ação do usuário
    login_as user
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'if not the owner cannot edit recipe' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user, cuisine: cuisine, recipe_type: recipe_type)

    visit root_path
    click_on recipe.title

    expect(page).to_not have_link('Editar')
  end

  scenario 'user cannot access edit form via url if not owner' do
    other_user = create(:user, email: 'email2@email.com', password: '123456')
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user, cuisine: cuisine, recipe_type: recipe_type)

    login_as other_user
    visit edit_recipe_path(recipe)

    expect(current_path).to eq root_path
  end

end
