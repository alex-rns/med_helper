Rails.application.routes.draw do
  get '/search', to: 'experts#index', as: 'search_experts'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#testbootstrap', as: "home"
  resources :experts, only: [:show]
  resources :users
end
