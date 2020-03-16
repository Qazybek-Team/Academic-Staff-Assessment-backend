# frozen_string_literal: true

require 'sinatra/base'
require 'multi_json'

module ASAAPI
  class App < Sinatra::Application
    get '/api/v1/login' do
      session[:asaapi_token] = true
    end

    get '/api/v1/logout' do
      session[:asaapi_token] = nil
    end

    get '/api/v1/protected' do
      protected!

    end
  end
end

