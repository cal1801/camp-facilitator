class SchedulesController < ApplicationController
  before_action :authenticate_user!, :check_account, :set_camp, :set_variables
  before_action :set_last_seen_at, if: proc { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 15.minutes.ago) }

  def index
  end

  def your_work_schedule
    @activities_by_week = current_user.activities.upcoming.order(:day, :start).group_by{ |a| a.day.beginning_of_week }
  end

  private
  def check_account
    if current_user.account.nil?
      redirect_to new_account_path
    end
  end

  def set_camp
    if params["camp"].present? && current_user.master_admin?
      @camp = Camp.find(params["camp"])
    else
      @camp = current_user.camp
    end

  end

  def set_last_seen_at
    current_user.update_column(:previously_seen_at, current_user.last_seen_at)
    current_user.update_column(:last_seen_at, Time.now)
  end
end
