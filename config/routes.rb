Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    member do
      patch :mark_unread
    end
    resource :favorites, only: [:create, :destroy]
  end

  root to: "application#home"
end
