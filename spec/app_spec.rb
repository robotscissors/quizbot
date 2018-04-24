ENV['RACK_ENV'] = 'development'

require_relative '../app.rb'  # <-- your sinatra app
require 'rspec'
require 'rack/test'

describe 'The App is functioning' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "gets a response" do
    get '/'
    expect(last_response).to be_ok
  end

end
