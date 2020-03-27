# frozen_string_literal: true

require 'sinatra/base'

SOURCE_DIR = File.dirname __FILE__

HELPERS_DIR = File.join SOURCE_DIR, 'helpers'
ENDPOINTS_DIR = File.join SOURCE_DIR, 'endpoints'


# Middlewares
require 'asaapi/rack/json_middleware'

# Helpers
Dir["#{HELPERS_DIR}/*.rb"].sort.each { |file| require file }

module ASAAPI
  class App < Sinatra::Application
    use Rack::JsonMiddleware

    use ::Rack::Session::Pool


    set :root, ASAAPI_APP_ROOT
    set :port, ENV['PORT']
    set :protection, :except => [:json_csrf]

    before do
      headers(
        'Access-Control-Allow-Origin' => 'http://localhost:3000',
        'Access-Control-Allow-Headers' => '*',
        'Access-Control-Allow-Methods' => '*',
        'Access-Control-Allow-Credentials' => 'true'
      )
    end
  end
end


Dir["#{ENDPOINTS_DIR}/*.rb"].sort.each { |file| require file }
