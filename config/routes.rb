Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  #api v1
  namespace :api do
    namespace :v1 do
      resources :users, only: :index
      resources :clients, only: :index
      resources :persons, only: :index
    end
  end
end
