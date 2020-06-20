Rails.application.routes.draw do
  default_url_options host: 'http://localhost:3000/'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :events

  namespace :admin do
    root to: 'events#index'

    resources :events do
      member do
        put :approve
        put :decline
      end

      collection do
        get :pending
      end
    end
  end

  root to: 'events#index'
end
