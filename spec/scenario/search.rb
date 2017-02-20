require "rails_helper"

feature "Searching" do
  let!(:category) { create(:category, name: "Festas", code: "festas") }
  let!(:company1) { create(:company, name: "aaaa1", slug: "aaaa1") }
  let!(:company2) { create(:company, category: category) }
  let!(:city)     { create(:city) }

  before do
    visit root_url
  end

  scenario "by the name" do
    within("#index-banner") do
      fill_in("key", with: "aaa")
      click_button("search-button")
    end

    expect(page).to have_content("Você buscou: aaa")
    expect(page).to have_content("aaaa1")
    expect(page).to_not have_content(company2.name)
  end

  scenario "by category" do
    within("#index-banner") do
      fill_in("key", with: category.name)
      click_button("search-button")
    end

    expect(page).to have_content("Você buscou:")
    expect(page).to have_content(category.name)
    expect(page).to_not have_content("aaaa1")
    expect(page).to have_content(company2.name)
  end

  scenario "by city" do
    company1.profile.update(city_id: city.id)
    within("#index-banner") do
      fill_in("key", with: city.name)
      click_button("search-button")
    end

    expect(page).to have_content("Você buscou: #{city.name}")
    expect(page).to have_content(company1.name)
    expect(page).to_not have_content(company2.name)
  end
end
