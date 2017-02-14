Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'

  resources :users, only: [:show, :edit, :update] do
    resources :recipes
    resources :ratings
  end

  resources :ingredients
  resources :ratings, only: [:destroy]

  resources :recipes do
    resources :ratings
  end

  namespace :admin do
    resources :users, only: [:index, :show, :destroy, :ban]
    get '/users/:id/ban', to: 'users#ban'
    get '/users/:id/unban', to: 'users#unban'
  end

  get '/recipes/:id/remove', to: 'recipes#remove'

end
