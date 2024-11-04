Rails.application.routes.draw do
  get "home/index"
  get "register", to: "registrations#new", as: :register
  post "register", to: "registrations#create"

  # Admin Routes
  namespace :admin do
    resources :users, only: [ :new, :create ]
  end

  resources :job_offers, only: [ :index, :new, :create, :show ]

  devise_scope :user do
    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  # Devise routes without registration
  devise_for :users, skip: [ :registrations ]

  # Health and PWA routes
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
