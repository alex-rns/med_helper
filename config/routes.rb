Rails.application.routes.draw do
  get '/search', to: 'experts#index', as: 'search_experts'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
				    registrations: "users/registrations" }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#testbootstrap', as: "home"
  get '/role', to: 'pages#role', as: "role"
  resources :experts, only: [:show, :index, :edit, :update] do
    resources :cards, only: [:new, :create, :show, :update]
    member do
      get 'pacient'
    end
    resources :events, only: [:index, :new, :create, :show, :update] do
      resources :visits, only: [:index, :new, :create, :show]
    end
  end
  resources :users do
    resources :events, only: [:index, :show, :update]
    resources :vaccines, only: [:show, :edit, :update]
    resources :children do
      resources :vaccines, only: [:show, :edit, :update]
    end
  end
end
