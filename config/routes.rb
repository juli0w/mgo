Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' }

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
    resources :subscribes
    resources :fonts
    get 'dashboard', to: 'backstage#dashboard'
    root to: 'backstage#dashboard'
    resources :users do
      member do
        post :become
      end
    end
    resources :categories, except: :show
    resources :sample_templates

    resources :companies do
      member do
        post :active
        post :unactive
      end

      resources :pages do
        resources :contact_pages
        resources :blank_pages
        resources :blog_pages
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

  post ':slug', to: 'companies#show'
  get  ':slug', to: 'companies#show'
  get  ':slug/review', to: 'reviews#new'
  get  ':slug/:paging', to: 'companies#show'
  get  ':slug/:paging/:article', to: 'companies#article'
  post ':slug/:paging/:article/comment', to: 'comments#create', as: :company_article_comments
  delete ':slug/:paging/:article/comment/:id', to: 'comments#destroy', as: :destroy_company_article_comments
end
