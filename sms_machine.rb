class SmsFactory
  def self.send_sms(to_number, body_text)
    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
    @client.messages.create(
      to: to_number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: body_text
    )
  end
end
