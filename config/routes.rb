Rails.application.routes.draw do
  # Devise routes for coaches
  devise_for :coaches, controllers: {
    registrations: 'coaches/registrations',
    sessions: 'coaches/sessions',
    passwords: 'coaches/passwords'
  }

  # Root and Welcome page
  root 'welcome#index'

  get 'dashboard', to: 'teams#dashboard'

  # Public routes
  resources :teams do
    resources :events
  end

  # Admin routes
  resources :events, except: [:index, :show] 
  resources :teams, except: [:index, :show] 
  resources :coaches

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
