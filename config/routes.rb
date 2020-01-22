Rails.application.routes.draw do
  resources :activities do
    member do
      post 'add_worker'
      post 'remove_worker'
    end
  end
  resources :guest_groups, except: [:index]
  resources :camps do
    collection do
      post 'send_invite'
      post 'remove_account_from_camp'
      post 'get_report_data'
    end
    member do
      get 'camp_staff'
      get 'reporting'
    end
  end
  resources :accounts, except: [:show, :index]
  devise_for :users, :controllers => { :invitations => 'users/invitations' }
  get "schedules/index"
  get "schedules/your_work_schedule"
  root "schedules#index"
end
