Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :users, only: [] do
    resources :user_grudges, only: :index
  end
  resources :user_grudges, only: [:new, :create]
end
