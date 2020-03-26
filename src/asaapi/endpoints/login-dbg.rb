# frozen_string_literal: true

require 'sinatra/base'
require 'multi_json'
require 'oauth2'
require 'faraday'
require 'jwt'

require 'asaapi/config'

module ASAAPI
  class App < Sinatra::Application
    get '/api/v1/auth/login' do
      session[:asaapi_token] = '<authorized>'

      redirect params[:from], 307
    end

    get '/api/v1/auth/logout' do
      session.clear
    end

    get '/api/v1/user/account' do
      protected!

      headers 'Content-Type' => 'application/json'

      send_resource 'dummy-data.json'
    end
  end
end
