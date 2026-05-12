Rails.application.routes.draw do
  devise_for :admins, path: "admin", path_names: {
    sign_in: "login", sign_out: "logout"
  }, skip: [ :registrations ], controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords"
  }

  namespace :admin do
    root to: "dashboard#index"
    get "dashboard", to: "dashboard#index"
    resources :users, only: [ :index, :show ]
    # 将来の拡張用（後続Issueで実装）
    # resources :reports, only: [:index, :show, :update]
    # resources :shops,   only: [:index, :show, :update, :destroy] do
    #   collection { post :merge }
    # end
  end

  get "home/index"
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  get "terms" => "pages#terms", as: :terms
  get "privacy" => "pages#privacy", as: :privacy

  root "home#index"

  resources :shops, only: [ :index, :show ] do
    collection do
      get :select
      get :map
    end
    resources :reviews, only: [ :new, :create ]
  end
end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
# Can be used by load balancers and uptime monitors to verify that the app is live.

# Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
# get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
# get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

# Defines the root path route ("/")
