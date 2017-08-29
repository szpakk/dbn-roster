Rails.application.routes.draw do
  resources :users
  resources :rosters
  root to: 'rosters#new'
end
