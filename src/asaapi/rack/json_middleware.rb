# frozen_string_literal: true

require 'rack'
require 'multi_json'
require 'hashie/mash'

module ASAAPI
  module Rack
    class JsonMiddleware
      def initialize(app)
        @app = app
      end

      # noinspection RubyResolve
      def call(env)
        return @app.call env unless %w[GET POST].include? env['REQUEST_METHOD']

        body = Hashie::Mash.new(
          MultiJson.load(::Rack::Request.new(env).body,
                         symbolize_keys: true)
        )

        env.update request: body

        code, headers, body = @app.call env

        body = MultiJson.dump body

        headers['Content-Type'] = 'application/json; charset=utf-8'
        headers['Content-Length'] = body.length.to_s

        [code, headers, [body]]
      end

      private

      def nil_if_empty(body)
        body.empty? ? '{}' : body
      end
    end
  end
end
