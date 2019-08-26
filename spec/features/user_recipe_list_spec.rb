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

  scenario 'and unique name' do
    user = create(:user)
    RecipeList.create(name: 'Churrasco', user: user)

    login_as user
    visit root_path
    click_on 'Criar lista de receitas'
    fill_in 'Nome da lista', with: 'Churrasco'
    click_on 'Criar lista'

    expect(page).to have_content('Já possui uma lista com este nome')
  end
end