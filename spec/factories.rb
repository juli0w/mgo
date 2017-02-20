FactoryGirl.define do
  factory :category do
    name 'Vida noturna'
    code 'nightlife'
  end

  factory :admin, class: User do
    email 'admin@admin.com.br'
    admin true
  end

  factory :company do
    category
    profile { |c| c.create_profile }
    sequence(:name) { |n| "Company #{n}" }
    sequence(:slug) { |n| "slug-company-#{n}" }
  end

  factory :city do
    name "New York"
  end
end
