class SchedulesController < ApplicationController
  before_action :authenticate_user!, :check_account, :set_variables

  def index
  end

  def your_work_schedule
    @activities_by_week = current_user.activities.group_by{ |a| a.day.beginning_of_month }
  end

  private
  def check_account
    if current_user.account.nil?
      redirect_to new_account_path
    end
  end

  def set_variables
    @camp = current_user.camp
    @camp_accounts = @camp.accounts
    @camp_pending_accounts = @camp.users.select{|u| u.account.nil?}
    @guest_groups = @camp.guest_groups.order(:arrives)
  end
end
