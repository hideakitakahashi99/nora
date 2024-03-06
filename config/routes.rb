Rails.application.routes.draw do
  namespace :customer do
  resources :trials, only: [:new, :create] do
    collection do
        post 'confirm'
        post 'back'
        get 'done'
    end
  end
end

  root to:  'customer/pages#home'
  
 
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, controllers: {
    sessions: 'customer/sessions',
    registrations: 'customer/registrations'
  }

  namespace :admin do
    root to: 'pages#home'
    resources :orders, only: %i[show update]
    resources :customers, only: %i[index show update]
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
    resources :trials, only: [:new, :create] do
      collection do
          post 'confirm'
          post 'back'
          get 'done'
      end
    end
get 'pages/term'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
