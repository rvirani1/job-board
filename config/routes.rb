Rails.application.routes.draw do
  devise_for :users

  resources :jobs do
    resource :favorites, only: [:create, :destroy]
  end

  root to: "application#home"
end
