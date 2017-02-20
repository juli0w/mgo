require "rails_helper"

feature "User sessions" do
  scenario "Signing in with correct credentials" do
    login 'admin@admin.com', '123123'
    expect(page).to have_content 'Logado com sucesso'
  end

  scenario "Signing out" do
    login 'admin@admin.com', '123123'
    logout
    expect(page).to have_content 'Deslogado com sucesso'
  end

  scenario "Signing in as another user" do
    login 'fake@admin.com', 'fake'
    expect(page).to have_content 'Usuário ou senha inválido'
  end

  scenario "Register an user" do
    visit root_url
    first(:link, 'Registrar').click
    within('#new_user') do
      fill_in 'user[email]', with: 'teste@testee.com'
      fill_in 'password', with: '123123'
      fill_in 'password-again', with: '123123'
    end
    click_button "Confirmar"
    expect(page).to have_content 'Seu cadastro foi realizado com sucesso!'
  end

  scenario "Registering user with no password match" do
    visit root_url
    first(:link, 'Registrar').click
    within('#new_user') do
      fill_in 'user[email]', with: 'teste@teste.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: '123password'
    end
    click_button "Confirmar"
    expect(page).to have_css 'div.field_with_errors'
  end
end
