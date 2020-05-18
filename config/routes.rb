# typed: strict
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # api v1
  namespace :api do
    namespace :v1 do
      resources :users, only: :index
      resources :clients, only: :index
      resources :persons
    end
  end
end
