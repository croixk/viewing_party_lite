Rails.application.routes.draw do
  resources :parties
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  get '/register', to: 'users#new'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login'


  # get '/users', to: 'users#show'
  resources :users, only: [:show, :create ] do
    resources :user_parties, only: [:create]
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :parties, only: [:show, :new, :create]
    end
  end
end
