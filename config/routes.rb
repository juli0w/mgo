Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' },
              :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'home', to: 'home#index'
  get 'institutional', to: 'home#institutional'
  get 'search', to: 'home#search'
  get 'contact', to: 'home#contact'
  get 'map', to: 'maps#resources'
  get 'offers', to: 'offers#index'
  get 'offers/search', to: 'offers#search', as: :search_offer
  get 'partner', to: 'subscribes#new'

  resources :categories, only: :show
  resources :subscribes

  resources :companies, only: :show do
    resources :reviews, only: [:new, :create]
  end

  namespace :backstage do
    namespace :admin do
      resources :contacts
      resources :fonts
      resources :categories, except: :show
      resources :sample_templates
      resources :users do
        member do
          post :become
        end
      end
    end
    resources :subscribes
    get 'dashboard', to: 'backstage#dashboard'
    root to: 'backstage#dashboard'

    resources :companies do
      member do
        post :active
        post :unactive
      end

      resources :pages do
        resources :contact_pages
        resources :blank_pages
        resources :blog_pages
        resources :landing_pages
        resources :upsell_pages
        resources :album_pages do
          resources :photos
        end
      end

      resources :articles
      resources :contacts

      resource :profile, except: :show, path_names: { edit: '' } do
        member do
          get :preview
        end
      end

      resources :reviews, except: [:new, :create]
    end
  end

  resources :contacts

  get 'tags/:tag', to: 'companies#tag', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: 'home#index'

  get "auth", to: "auth#login"
  get "register", to: "auth#register"

  get 'robots.txt' => 'home#robots'
  get  'sitemap.xml', :to => 'home#sitemap', :defaults => {:format => 'xml'}
  get  'sitemap_index.xml', :to => 'home#sitemap_index', :defaults => {:format => 'xml'}

  get 'not_found', to: 'home#not_found'

  post ':slug', to: 'companies#show'
  get  ':slug', to: 'companies#show'

  post ':slug/ahoy/events', to: redirect("http://weekz.com.br/ahoy/events")
  put  ':slug/ahoy/events', to: redirect("http://weekz.com.br/ahoy/events")

  get  ':slug/robots.txt', :to => 'companies#robots'
  get  ':slug/sitemap.xml', :to => 'companies#sitemap', :defaults => {:format => 'xml'}
  get  ':slug/review', to: 'reviews#new'
  get  ':slug/:paging', to: 'companies#paging'
  get  ':slug/:paging/search', to: 'companies#search'
  get  ':slug/:paging/:article', to: 'companies#article'
  post ':slug/:paging/:article/comment', to: 'comments#create', as: :company_article_comments
  delete ':slug/:paging/:article/comment/:id', to: 'comments#destroy', as: :destroy_company_article_comments
end
