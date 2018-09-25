class WelcomeController < ActionController::Base
  before_action :authenticate_user!, :check_account

  private
  def check_account
    if current_user.account.nil?
      redirect_to new_account_path
    end
  end
end
