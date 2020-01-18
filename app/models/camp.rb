class Camp < ApplicationRecord
  has_many :users, dependent: :delete_all
  has_many :accounts, through: :users
  has_many :guest_groups, dependent: :delete_all

  def set_variables(past)
    camp_accounts = self.accounts
    camp_pending_accounts = self.users.select{|u| u.account.nil?}
    if past != 'true'
      guest_groups = self.guest_groups.upcoming.order(:arrives)
    else
      guest_groups = self.guest_groups.past.order(:arrives)
    end

    return camp_accounts, camp_pending_accounts, guest_groups
  end
end
