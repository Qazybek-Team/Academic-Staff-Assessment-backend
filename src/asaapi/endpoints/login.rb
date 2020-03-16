# frozen_string_literal: true

require 'sinatra/base'
require 'multi_json'
require 'oauth2'

require 'asaapi/config'

module ASAAPI
  class App < Sinatra::Application
    post '/api/v1/auth/get-token' do
      pp Config.credentials.current

      client = ::OAuth2::Client.new(
        Config.credentials.current[:client_id],
        Config.credentials.current[:client_secret],
        site: Config.credentials.current[:server_url]
      )

      {
        redirect: client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback')
      }
    end

    post '/api/v1/logout' do
      session[:asaapi_token] = nil
    end

    post '/api/v1/protected' do
      protected!

    end
  end
end

