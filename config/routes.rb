Rails.application.routes.draw do
  resources :activities
  resources :guest_groups
  resources :camps do
    collection do
      post 'send_invite'
    end
  end
  resources :accounts
  devise_for :users
  get "schedules/index"
  root "schedules#index"
end
