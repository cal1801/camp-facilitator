class SchedulesController < ApplicationController
  before_action :authenticate_user!, :check_account

  def index
    @camp = current_user.camp
    @camp_accounts = @camp.accounts
    @camp_pending_accounts = @camp.users.select{|u| u.account.nil?}
    @guest_groups = @camp.guest_groups
  end

  private
  def check_account
    if current_user.account.nil?
      redirect_to new_account_path
    end
  end
end
