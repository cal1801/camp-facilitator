require "#{Rails.root}/lib/twilo/sms"
class Account < ApplicationRecord
  #first_name, last_name, phone_number, carrier
  validates :first_name, :last_name, presence: true
  validates :phone_number, length: { is: 14 }, :allow_blank => true
  #validates_presence_of :carrier, :if => :phone_number?

  has_one :user
  #enum carrier: ["AT&T", "T-Mobile", "Verizon", "Sprint", "Virgin Mobile",
                 #"Tracfone", "Metro PCS", "Boost Mobile", "Cricket",
                 #"Republic Wireless", "Google Fi", "U.S. Cellular", "Ting",
                 #"Consumer Cellular", "C-Spire", "Page Plus"]

  def name_with_initial
    "#{self.first_name} #{self.last_name[0]}."
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.send_week_work_emails
    accounts = Account.all.reject{|a| a.user.nil?}

    accounts.each do |this_account|
      unless this_account.user.activities.empty? || this_account.user.nil?
        activities = this_account.user.activities.where("day = ?", Date.today()+7)
        unless activities.empty?
          puts "Sending #{activities.count} to #{this_account.name_with_initial}"
          WorkNotifierMailer.send_work_email(this_account, activities, "week").deliver!

          message = "Work Reminder for this week \n"
          activities.each do |activity|
            message += "#{activity.day_and_time_span} - #{activity.name} \n"
          end

          Twilio::SMS.send_sms(message, "+1#{this_account.phone_number.gsub(/\D/, '')}") unless this_account.phone_number.blank?
        end
      end
    end
  end

  def self.send_day_before_emails
    accounts = Account.all.reject{|a| a.user.nil?}

    accounts.each do |this_account|
      unless this_account.user.activities.empty? || this_account.user.nil?
        activities = this_account.user.activities.where("day = ?", Date.today()+1)

        unless activities.empty?
          puts "Sending #{activities.count} to #{this_account.name_with_initial}"
          WorkNotifierMailer.send_work_email(this_account, activities, "day").deliver!
          
          message = "Work Reminder for Tomorrow \n"
          activities.each do |activity|
            message += "#{activity.day_and_time_span} - #{activity.name} \n"
          end

          Twilio::SMS.send_sms(message, "+1#{this_account.phone_number.gsub(/\D/, '')}") unless this_account.phone_number.blank?
        end
      end
    end
  end

  #def self.carrier_emails
    #return {
    #  "AT&T" => "txt.att.net",
    #  "T-Mobile" => "tmomail.net",
    #  "Verizon" => "vtext.com",
    #  "Sprint" => "messaging.sprintpcs.com",
    #  "Virgin Mobile" => "vmobl.com",
    #  "Tracfone" => "mmst5.tracfone.com",
    #  "Metro PCS" => "mymetropcs.com",
    #  "Boost Mobile" => "sms.myboostmobile.com",
    #  "Cricket" => "sms.cricketwireless.net",
    #  "Republic Wireless" => "text.republicwireless.com",
    #  "Google Fi" => "msg.fi.google.com",
    #  "U.S. Cellular" => "email.uscc.net",
    #  "Ting" => "message.ting.com",
    #  "Consumer Cellular" => "mailmymobile.net",
    #  "C-Spire" => "cspire1.com",
    #  "Page Plus" => "vtext.com"
    #}
  #end
end
