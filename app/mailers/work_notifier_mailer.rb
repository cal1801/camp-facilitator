class WorkNotifierMailer < ApplicationMailer
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
end
