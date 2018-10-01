Rails.application.routes.draw do
  resources :activities do
    member do
      post 'add_worker'
      post 'remove_worker'
    end
  end
  resources :guest_groups, except: [:show, :index]
  resources :camps do
    collection do
      post 'send_invite'
    end
  end
  resources :accounts, except: [:show, :index]
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  get "schedules/index"
  get "schedules/your_work_schedule"
  root "schedules#index"
end
