Rails.application.routes.draw do
  root 'home#index'
  devise_for :professionals

  resources :patients, only: [:new, :create]
  resources :sessions, only: [:new, :create]
end
