Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' }

  get 'profiles/new'

  get 'home', to: 'home#index'
  get 'institutional', to: 'home#institutional'
  get 'seach', to: 'home#search', as: 'search'
  get 'contact', to: 'home#contact', as: 'contact'
  get 'map', to: 'maps#resources'
  get 'offers', to: 'offers#index'

  resources :categories
  resources :users
  resources :subscribes
  get 'partner', to: 'subscribes#new', as: 'partner'

  resources :companies do
    resource :profile, except: :show, path_names: { edit: '' }

    resources :albums do
      resources :photos
    end

    resources :reviews
  end

  resources :contacts

  get 'tags/:tag', to: 'companies#tag', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: 'home#index'

  get ':slug', to: 'companies#show'
  get ':slug/review', to: 'reviews#new'
end
