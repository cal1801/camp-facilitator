Rails.application.routes.draw do
  resources :camps
  resources :accounts
  devise_for :users
  root 'welcome#index'
end
