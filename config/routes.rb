Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' }

  # get 'profiles/new'

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
    get 'dashboard', to: 'backstage#dashboard'
    root to: 'backstage#dashboard'
    resources :users do
      member do
        post :become
      end
    end
    resources :categories, except: :show

    resources :companies do
      member do
        post :active
        post :unactive
      end
      resource :profile, except: :show, path_names: { edit: '' }
      resources :albums do
        resources :photos
      end

      resources :reviews, except: [:new, :create]
    end
  end

  resources :contacts

  get 'tags/:tag', to: 'companies#tag', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: 'home#index'

  get ':slug', to: 'companies#show'
  get ':slug/review', to: 'reviews#new'
end
