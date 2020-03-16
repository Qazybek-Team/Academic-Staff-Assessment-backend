# frozen_string_literal: true

require 'sinatra/base'
require 'multi_json'
require 'oauth2'
require 'faraday'
require 'jwt'

require 'asaapi/config'

module ASAAPI
  class App < Sinatra::Application
    client = ::OAuth2::Client.new(
      Config.credentials.current['client_id'],
      Config.credentials.current['client_secret'],
      site: Config.credentials.current['server_url'],
      authorize_url: Config.credentials.current['authorize_url'],
      token_url: Config.credentials.current['token_url'],
      redirect_uri: 'https://innopoints-backend.herokuapp.com/authorize'
    )

    get '/api/v1/auth/sso' do
      session[:sso_redirect_after] = params[:from]

      redirect_url = client.auth_code.authorize_url

      redirect redirect_url, 307
    end

    get '/api/v1/auth/receive-token' do
      session[:sso_token] = MultiJson.dump(
        client.auth_code.get_token(params[:code]).to_hash
      )

      redirect session[:sso_redirect_after], 301
    end

    get '/authorize' do
      query = URI.encode_www_form params

      redirect "/api/v1/auth/receive-token?#{query}"
    end

    get '/api/v1/auth/sso-info' do
      token = MultiJson.load(session[:sso_token])

      ac_token = JWT.decode token['id_token'], nil, false

      ac_token
    end
  end
end

