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

  def self.seed_messages
    Camp.all.each do |camp|
      camp.week_out_message = '<h4>[FirstName]</h4><p>Good news, you are on the schedule in a week! &nbsp;Take a look below to confirm the times that we have for you to work. Please give us a call if you have any questions or need to talk about you schedule.</p><p>[Blocks]</p>'
      camp.day_out_message = '<h4>[FirstName]</h4><p>Just a quick reminder about your work that is happening tomorrow. As always, please give us a call if there is any issues.</p><p>[Blocks]</p>'
      camp.save!
    end
  end
end
