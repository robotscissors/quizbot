require 'bundler'
Bundler.require()


get '/' do
  'Sinatra has taking the stage.'
end

post '/sms' do
  twiml = Twilio::TwiML::MessagingResponse.new do |r|
    r.message("This works - response!")
  end

  content_type "text/xml"

  twiml.to_s
end
