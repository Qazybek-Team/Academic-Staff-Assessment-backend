# frozen_string_literal: true

require 'sinatra/base'

# Middlewares
require 'asaapi/rack/json_middleware'

# Helpers
require 'asaapi/helpers/auth_helper'
require 'asaapi/helpers/base_url'

module ASAAPI
  class App < Sinatra::Application
    use Rack::JsonMiddleware

    use ::Rack::Session::Pool, domain: 'innopoints-backend.herokuapp.com'


    set :root, ASAAPI_APP_ROOT
    set :port, ENV['PORT']

    before do
      headers(
        'Access-Control-Allow-Origin' => 'http://localhost:3000',
        'Access-Control-Allow-Headers' => '*',
        'Access-Control-Allow-Methods' => '*'
      )
    end
  end
end

# Endpoints
require 'asaapi/endpoints/ping_pong'
require 'asaapi/endpoints/login'
