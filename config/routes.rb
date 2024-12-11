Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/index'
  devise_for :professionals

  resources :sessions, only: [:new, :create] do
    member do
      patch :mark_as_paid
    end
  end
  resources :patients, only: [:new, :create, :edit, :update] do
    member do
      patch 'toggle_active'
    end
  end
  
  

  get 'home/my_patients', to: 'home#my_patients'
  get 'home/my_sessions', to: 'home#my_sessions'
end
