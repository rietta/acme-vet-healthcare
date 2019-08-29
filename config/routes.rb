# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :products

  resource :cart, only: [] do
    get :add
    get :remove
  end

  namespace :admin do
    resources :users
    resources :medications, except: %w[new edit]
  end

  resources :orders, only: %w[new create]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'pages#home'
end
