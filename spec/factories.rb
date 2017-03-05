FactoryGirl.define do
  factory :sample_template do
    name "MyString"
    template nil
  end
  factory :template do
    primary_color nil
    detail_color nil
    link_color nil
    text_color nil
    logo_color nil
    description_color_id 1
  end
  factory :color do
    name "MyString"
  end
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
