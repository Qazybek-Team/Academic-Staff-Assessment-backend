# frozen_string_literal: true

require 'sinatra/base'

# Middlewares
require 'asaapi/rack/json_middleware'

# Helpers
require 'asaapi/helpers/auth_helper'

module ASAAPI
  class App < Sinatra::Application
    use Rack::JsonMiddleware

    enable :sessions

    set :root, ASAAPI_APP_ROOT
  end
end

# Endpoints
require 'asaapi/endpoints/ping_pong'
require 'asaapi/endpoints/login'
