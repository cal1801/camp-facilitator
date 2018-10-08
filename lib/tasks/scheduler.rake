desc "This task is called by the Heroku scheduler add-on"
task :one_week_out => :environment do
  puts "Sending out 1 week reminders."
  Account.send_week_work_emails
  puts "Sent."
end

task :send_reminders => :environment do
  puts "Sending out day before reminders."
  Account.send_day_before_emails
  puts "Sent."
end
