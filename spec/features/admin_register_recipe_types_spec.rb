require 'rails_helper'

feature 'admin register recipe types' do
  scenario 'successfully' do
    visit root_path
    click_on 'Enviar tipo de receita'

    fill_in 'Nome',  with: 'Café da Manhã'
    click_on 'Enviar'

    expect(page).to have_content('Tipo de receita cadastrada com sucesso')
  end

  scenario 'and must fill in all fields' do
    visit root_path
    click_on 'Enviar tipo de receita'

    fill_in 'Nome',  with: ''
    click_on 'Enviar'

    expect(page).to have_content('Tipo de receita não cadastrada')
  end

  scenario 'and name must be unique' do
    RecipeType.create(name: 'Sobremesa')

    visit root_path
    click_on 'Enviar tipo de receita'

    fill_in 'Nome',  with: 'Sobremesa'
    click_on 'Enviar'

    expect(page).to have_content('Tipo de receita não cadastrada')
  end
end
