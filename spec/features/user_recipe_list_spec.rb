require 'rails_helper'

feature 'User create recipe list' do
  scenario 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Criar lista de receitas'
    fill_in 'Nome da lista', with: 'Churrasco'
    click_on 'Criar lista'

    expect(page).to have_content('Lista criada com sucesso')
    expect(page).to have_css('h3', text: 'Lista de Churrasco')
  end

  scenario 'and user see all lists' do
    user = create(:user)
    RecipeList.create(name: 'Churrasco', user: user)
    recipe_list = RecipeList.create(name: 'Sorveteria', user: user)

    login_as user
    visit root_path
    click_on 'Ver listas'

    expect(page).to have_css('h3', text: "Listas do usuário #{user.email}")
    expect(page).to have_link(recipe_list.name)
  end

  scenario 'and lists must be unique name' do
    user = create(:user)
    RecipeList.create(name: 'Churrasco', user: user)

    login_as user
    visit root_path
    click_on 'Criar lista de receitas'
    fill_in 'Nome da lista', with: 'Churrasco'
    click_on 'Criar lista'

    expect(page).to have_content('Já possui uma lista com este nome')
  end

  scenario 'and add recipe in list' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, title: 'Salada de maionese', cuisine: cuisine,
                    user: user, recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Sopa de feijão', cuisine: cuisine,
                          user: user, recipe_type: recipe_type)
    RecipeList.create(name: 'Churrasco', user: user)

    login_as user
    visit recipe_path(recipe)
    click_on 'Adicionar a lista'

    expect(page).to have_css('h3', text: 'Lista de Churrasco')
    expect(page).to have_content(recipe.title)
    expect(page).to_not have_content(other_recipe.title)
  end
end