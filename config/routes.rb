Rails.application.routes.draw do
  resources :camps
  resources :accounts
  devise_for :users
  get "schedules/index"
  root "schedules#index"
end
