require "rails_helper"

feature "Exploring companies" do
  before { login 'admin@admin.com', '123123' }
  scenario "Creating a company" do
    first(:link, "Painel").click
    first(:link, "Nova empresa").click

    within("#new_company") do
      fill_in 'company[name]', with: 'Teste'
      fill_in 'company[slug]', with: 'teste-slug'
      fill_in 'company[description]', with: 'teste description of company'
    end
    click_button("Salvar")

    expect(page).to have_content 'Empresa criada'
    expect(current_path).to eq(edit_backstage_company_profile_path(Company.last))
    first(:link, "Visitar").click
    expect(page).to have_content 'teste description of company'
  end

  scenario "Changing company profile" do
    user = User.where(email: 'admin@admin.com').first
    company = create(:company, user: user, mail: "email@email.com")
    visit edit_backstage_company_profile_path(company)

    within("form.edit_profile") do
      fill_in "profile[institutional]", with: "Profile company page"

      click_button "Salvar"
    end

    expect(page).to have_content 'Salvo com sucesso!'
    click_link 'Visitar'
    expect(current_path).to eq("/#{company.slug}")
    expect(page).to have_content("email@email.com")
    expect(page).to_not have_content("Profile company page")

    company.activate!
    visit "/#{company.slug}"
    expect(page).to have_content("Profile company page")
  end
end
