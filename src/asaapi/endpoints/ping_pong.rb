# frozen_string_literal: true

require 'sinatra/base'
require 'multi_json'

module ASAAPI
  class App < Sinatra::Application
    get '/ping' do
      MultiJson.dump ping: 'pong'
    end
  end
end
