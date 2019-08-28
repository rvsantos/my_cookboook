require 'rails_helper'

feature 'Admin allows recipes' do
  scenario 'new recipe start with status pending' do
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                    recipe_type: recipe_type)

    login_as user
    visit root_path

    expect(recipe.pending?).to eq true
    expect(page).to_not have_css('h1', text: recipe.title)
  end

  scenario 'if user as admin change status of recipes' do
    user = create(:user)
    admin = User.create(email: 'admin@admin.com', password: '123456',
                        admin: true)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, user: user, cuisine: cuisine,
                    recipe_type: recipe_type)

    login_as admin
    visit root_path
    click_on 'Receitas pendentes'
    within("#recipe-#{recipe.id}") do
      click_on 'Published'
    end

    # recipe.reload
    expect(page).to have_content('Receita publicada com sucesso')
    expect(page).to have_content('Published')
  end

  scenario 'if user as admin change status of recipes for reviewed' do
    user = create(:user)
    admin = User.create(email: 'admin@admin.com', password: '123456',
                        admin: true)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    recipe = create(:recipe, title: 'Bolo de Jacá', user: user, cuisine: cuisine,
                    recipe_type: recipe_type)

    login_as admin
    visit root_path
    click_on 'Receitas pendentes'
    within("#recipe-#{recipe.id}") do
      click_on 'Reviewed'
    end

    # recipe.reload
    expect(page).to have_content('Receita rejeitada')
    expect(page).to have_content('Reviewed')
  end
end