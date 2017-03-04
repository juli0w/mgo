require "rails_helper"
require 'support/capybara'

feature "Searching" do
  let!(:category) { create(:category, name: "Festas", code: "festas") }
  let!(:company1) { create(:company, name: "aaaa1", slug: "aaaa1") }
  let!(:company2) { create(:company, category: category) }
  let!(:city)     { create(:city) }

  before do
    visit root_url
  end

  scenario "by the name" do
    within(".search-nav") do
      fill_in("key", with: "aaa")
      page.submit(find("#search_form"))
    end

    expect(page).to have_content("Resultados para: aaa")
    expect(page).to have_content("aaaa1")
    expect(page).to_not have_content(company2.name)
  end

  scenario "by category" do
    within(".search-nav") do
      fill_in("key", with: category.name)
      page.submit(find("#search_form"))
    end

    expect(page).to have_content("Resultados para:")
    expect(page).to have_content(category.name)
    expect(page).to_not have_content("aaaa1")
    expect(page).to have_content(company2.name)
  end

  scenario "by city" do
    company1.update(city_id: city.id)
    within(".search-nav") do
      fill_in("key", with: city.name)
      page.submit(find("#search_form"))
    end

    expect(page).to have_content("Resultados para: #{city.name}")
    expect(page).to have_content(company1.name)
    expect(page).to_not have_content(company2.name)
  end
end
