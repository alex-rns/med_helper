Rails.application.routes.draw do
  get '/search', to: 'experts#index', as: 'search_experts'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
				    registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#testbootstrap', as: "home"
  get '/role', to: 'pages#role', as: "role"
  resources :experts, only: [:show, :index, :edit, :update] do
    resources :events, only: [:new, :create, :show]
  end
  resources :users do
    resources :vaccines, only: [:show, :edit, :update]
  end
end
