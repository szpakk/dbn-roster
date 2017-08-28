Rails.application.routes.draw do
  resources :rosters
  root to: 'rosters#new'
end
