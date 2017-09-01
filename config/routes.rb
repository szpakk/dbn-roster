Rails.application.routes.draw do
  get '/home',       to: 'static_pages#home'

  resources :users
  resources :rosters
  resources :players
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root to: 'static_pages#home'
end
