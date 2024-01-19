Rails.application.routes.draw do

  root to:  'customer/products#index'
  namespace :customer do
    get 'customers/confirm_withdraw'
    get 'orders/index'
    get 'orders/show'
    get 'orders/success'
    get 'cart_items/index'
    get 'products/index'
    get 'products/show'
  end
  namespace :admin do
    root to: 'pages#home'
    resources :orders, only: %i[show update]
    resources :customers, only: %i[index show update]
    get 'products/index'
    get 'products/show'
    get 'products/new'
    get 'products/edit'
  end
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations'
  }

  namespace :admin do
    resources :products, only: %i[index show new create edit update]
  end

  scope module: :customer do
    resources :products, only: %i[index show]
    resources :cart_items, only: %i[index create destroy] do
      member do
        patch 'increase'
        patch 'decrease'
      end
    end
    resources :checkouts, only: [:create]
    resources :webhooks, only: [:create]
    resources :orders, only: %i[index show] do
      collection do
        get 'success'
      end
    end
    resources :customers do
      collection do
        get 'confirm_withdraw'
        patch 'withdraw'
      end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
