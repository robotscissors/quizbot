require 'bundler'
Bundler.require()
require 'rack/env'
use Rack::Env

get '/' do
  'Sinatra has taking the stage. Cell:'+ENV['TWILIO_PHONE_NUMBER']
end

post '/sms' do
  twiml = Twilio::TwiML::MessagingResponse.new do |r|
    r.message("This works - response!")
  end

  content_type "text/xml"

  twiml.to_s
end
