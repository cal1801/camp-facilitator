class WorkNotifierMailer < ApplicationMailer
  default from: 'reminder@thecampschedule.com'

  def send_work_email(account,activities,time_frame)
    @account = account
    @activities = activities
    @time_frame = time_frame
    if @time_frame == "week"
      subject = 'Work scheduled a week from today'
    else
      subject = 'Reminder about work tomorrow'
    end

    mail(
      :to => @account.user.email,
      :from => @account.user.camp.users.select{|u| u.camp_admin? || u.master_admin?}.first.email,
      :subject => subject
    )
  end

  def activities_deleted(account, activities, guest_group_name)
    @account = account
    @activities = activities
    @guest_group_name = guest_group_name
    unless account.user.camp_admin?
      mail(
        :to => @account.user.email,
        :from => @account.user.camp.users.select{|u| u.camp_admin? || u.master_admin?}.first.email,
        :subject => "#{guest_group_name} removed activities"
      )
    end
  end

  def let_camp_admin_know(activity, user, method)
    @activity = activity
    @account = user.account
    @method = method
    camp_admin = @activity.guest_group.camp.users.select{|u| u.camp_admin? || u.master_admin?}.first
    unless user == camp_admin || user.camp_admin?
      mail(
        :to => camp_admin.email,
        :subject => "Schedule Update"
      )
    end
  end
end
