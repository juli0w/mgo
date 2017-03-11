FactoryGirl.define do
  factory :album_page do
    
  end
  factory :page do
    pageable_type "MyString"
    pageable_id 1
    title "MyString"
    profile nil
  end
  factory :blank_page do
    content "MyText"
  end
  factory :contact_page do
    email "MyString"
  end
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
