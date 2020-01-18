class ApplicationController < ActionController::Base
  before_action :set_timezone

  def set_variables
    @camp = current_user.camp if @camp.blank?
    @camp_accounts, @camp_pending_accounts, @guest_groups = @camp.set_variables(params['past'])
  end

  private
  def set_timezone
    Time.zone = 'Eastern Time (US & Canada)'
  end
end
