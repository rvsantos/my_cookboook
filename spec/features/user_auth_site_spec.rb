require 'rails_helper'

feature 'User authenticates on site' do
  scenario 'successfully' do
    User.create(email: 'email@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    within '#new_user' do
      fill_in "Email",	with: "email@email.com"
      fill_in "Password",	with: "123456"
      click_on 'Log in'
    end

    expect(page).to_not have_content('Entrar')
    expect(page).to have_content('Sair')
  end

  scenario 'successfully' do
    User.create(email: 'email@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'

    within '#new_user' do
      fill_in "Email",	with: "email@email.com"
      fill_in "Password",	with: "123456"
      click_on 'Log in'
    end
    click_on 'Sair'

    expect(page).to_not have_content('Sair')
    expect(page).to have_content('Entrar')
  end
end