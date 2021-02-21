Rails.application.routes.draw do
  get '/search', to: 'experts#index', as: 'search_experts'
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#testbootstrap', as: "home"
  resources :experts, only: [:show, :index] do
    resources :events, only: [:new, :create, :show]
  end
  resources :users do
    resources :vaccines, only: [:show]
  end
end
