Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :users, only: [:index] do
    resources :user_grudges, only: :index
  end

  resources :grudges, only: %i[new create]
  resources :user_grudges, only: %i[new create]
end
