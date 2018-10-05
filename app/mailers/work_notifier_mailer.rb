class WorkNotifierMailer < ApplicationMailer
  default from: 'reminder@thecampschedule.com'

  def send_work_email(account,activities)
    @account = account
    @activities = activities

    mail(
      :to => @account.user.email,
      :from => @account.user.camp.users.select{|u| u.camp_admin?}.first.email,
      :subject => 'Upcoming Work Schedule'
    )
  end

  def activities_deleted(account, activities, guest_group_name)
    @account = account
    @activities = activities
    @guest_group_name = guest_group_name

    mail(
      :to => @account.user.email,
      :from => @account.user.camp.users.select{|u| u.camp_admin?}.first.email,
      :subject => "#{guest_group_name} removed activities"
    )
  end

  def let_camp_admin_know(activity, user, method)
    @activity = activity
    @account = user.account
    @method = method
    camp_admin = @activity.guest_group.camp.users.select{|u| u.camp_admin?}.first
    unless user == camp_admin || user.camp_admin?
      mail(
        :to => camp_admin.email,
        :subject => "Schedule Update"
      )
    end
  end
end
