Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :events
  namespace :admin do
    root to: 'events#index'
    resources :events
  end

  root to: 'events#index'
end
