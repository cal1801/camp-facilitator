module Twilio
  class SMS
    def self.send_sms(message, phone)
      client = Twilio::REST::Client.new
      from = ENV["TWILO_PHONE_NUMBER"] # Your Twilio number
      client.messages.create({
        from: from,
        to: phone,
        body: message
      })
    end
  end
end