FactoryGirl.define do
  factory :lead do
    company nil
    email "MyString"
  end
  factory :newsletter do
    company nil
    top false
    bottom false
    message "MyString"
    action "MyString"
  end
  factory :subscribe_page do
    link "MyString"
    link_call "MyString"
  end
  factory :upsell_page do
    image "MyString"
    content "MyString"
    link "MyString"
    link_call "MyString"
  end
  factory :quote do
    phrase "MyString"
    author "MyString"
  end
  factory :landing_page do
    image "MyString"
    content "MyText"
    link "MyString"
  end
  factory :blog_page do
    max 1
    height 1
  end
  factory :article do
    company nil
    slug "MyString"
    title "MyString"
    content "MyText"
    description "MyString"
    cover "MyString"
  end
  factory :font do
    name "MyString"
    url "MyString"
    profile nil
  end
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
