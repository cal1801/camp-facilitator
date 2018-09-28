Rails.application.routes.draw do
  resources :activities
  resources :guest_groups
  resources :camps
  resources :accounts
  devise_for :users
  get "schedules/index"
  root "schedules#index"
end
