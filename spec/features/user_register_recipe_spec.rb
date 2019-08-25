require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = FactoryBot.create(:user)
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Arabe')

    # simula a ação do usuário
    login_as user
    visit new_recipe_path
    # click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    user = FactoryBot.create(:user)

    # simula a ação do usuário
    login_as user
    visit new_recipe_path
    # click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'only users authenticate can register recipes' do
    visit root_path

    expect(page).not_to have_link('Enviar uma receita')
  end

  scenario 'registered recipes linked with user' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = build(:recipe, recipe_type: recipe_type, user: user, cuisine: cuisine)

    login_as user
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: recipe.title
    select recipe.recipe_type.name, from: 'Tipo da Receita'
    select recipe.cuisine.name, from: 'Cozinha'
    fill_in 'Dificuldade', with: recipe.difficulty
    fill_in 'Tempo de Preparo', with: recipe.cook_time
    fill_in 'Ingredientes', with: recipe.ingredients
    fill_in 'Como Preparar', with: recipe.cook_method
    click_on 'Enviar'

    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_content("Receita enviada por #{user.email}")
    expect(page).to have_css('p', text: recipe.cuisine.name)
  end

  scenario 'and user can see your recipes registered' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = Recipe.create(title: 'Bolo de Jaca', user: user, cuisine: cuisine,
                  recipe_type: recipe_type, difficulty: 'facil', cook_time: 5,
                  ingredients: 'Farinha, ovo, jaca e leite',
                  cook_method: 'Mistura tudo')

    login_as user
    visit root_path
    click_on 'Minhas receitas'

    expect(page).to have_css('h1', text: 'Minhas receitas')
    expect(page).to have_link(recipe.title)
  end
end
