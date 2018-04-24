require 'rack-test'
require 'rspec'

ENV['RACK_ENV'] = 'development'

require File.expand_path '../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c| c.include RSpecMixin }
# If you use RSpec 1.x you should use this instead:
Spec::Runner.configure { |c| c.include RSpecMixin }
