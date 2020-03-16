require 'sinatra/base'

module ASAAPI
  class App < Sinatra::Application
    helpers do
      def protected!
        return if authorized?
        halt 401, "{ error: 'Not authorized!' }"
      end

      def authorized?
        auth_key = session[:asaapi_token]

        not auth_key.nil?
      end
    end
  end
end
