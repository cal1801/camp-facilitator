class SchedulesController < ApplicationController
  before_action :authenticate_user!, :check_account

  def index
    @camp = current_user.camp
    @camp_accounts = @camp.accounts
  end

  private
  def check_account
    if current_user.account.nil?
      redirect_to new_account_path
    end
  end
end
