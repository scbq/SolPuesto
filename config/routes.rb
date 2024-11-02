Rails.application.routes.draw do
  get "registrations/new"
  get "registrations/create"
  get "home/index"
  get "register", to: "registrations#new", as: :register
  post "register", to: "registrations#create"

  resources :applications
  resources :job_offers

  # Encapsula las rutas de Devise en un scope para asegurar el mapeo correcto
  devise_scope :user do
    authenticated :user do
      root to: "home#index", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  # Rutas adicionales de Devise
  devise_for :users, skip: [ :registrations ]

  # Rutas adicionales
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
