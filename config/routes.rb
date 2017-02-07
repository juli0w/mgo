Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' }

  get 'profiles/new'

  get 'home', to: 'home#index'
  get 'seach', to: 'home#search', as: 'search'
  get 'contact', to: 'home#contact', as: 'contact'
  get 'map', to: 'maps#resources'

  resources :categories
  resources :users
  resources :subscribes
  get 'partner', to: 'subscribes#new', as: 'partner'

  resources :companies do
    resource :profile, except: :show, path_names: { edit: "" }

    resources :albums do
      resources :photos
    end

    resources :reviews
  end

  resources :contacts

  get 'tags/:tag', to: 'home#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: 'maps#index'

  get ':slug', to: 'companies#show'
  get ':slug/review', to: 'reviews#new'
end
