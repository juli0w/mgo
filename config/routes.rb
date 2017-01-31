Rails.application.routes.draw do
  devise_for :users, path: '',
              path_names: {
                sign_in: 'login',
                sign_out: 'logout' }

  get 'profiles/new'

  get 'home', to: 'home#index'
  get 'seach', to: 'home#search', as: 'search'
  get 'contact', to: 'home#contact', as: 'contact'
  get 'partner', to: 'home#partner', as: 'partner'

  resources :categories
  resources :users

  resources :companies do
    resource :profile, except: :show, path_names: { edit: "" }
    resources :photos
    resources :reviews
  end

  resources :contacts

  get 'tags/:tag', to: 'home#index', as: :tag, :constraints  => { :tag => /[^\/]+/ }

  root to: 'home#index'

  get ':slug', to: 'companies#show'
  get ':slug/review', to: 'reviews#new'
end
