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
end
