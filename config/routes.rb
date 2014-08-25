Rails.application.routes.draw do
  devise_for :users

  get 'favorites' => 'favorites#index'

  resources :jobs do
    member do
      patch :mark_unread
    end
    resource :favorites, only: [:create, :destroy]
  end

  resources :companies

  resources :profiles

  root to: "application#home"
end
