Rails.application.routes.draw do
  get '/search', to: 'experts#index', as: 'search_experts'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
				    registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#home', as: "home"
  get '/role', to: 'pages#role', as: "role"
  resources :comments
  resources :pacients, only: [:index]
  resources :experts, only: [:show, :index, :edit, :update] do
    resources :events, only: [:index, :new, :create, :show, :update]
  end
  resources :users do
    resources :cards, only: [:show, :edit, :update] do
      resources :protocols, only: [:new, :create, :show]
    end
    resources :events, only: [:index, :show, :update]
    resources :vaccines, only: [:show, :edit, :update]
    resources :children do
      resources :vaccines, only: [:show, :edit, :update]
    end
  end
end
