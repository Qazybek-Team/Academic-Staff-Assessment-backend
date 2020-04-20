require_relative 'endpoint'

module RPC
  class Environment
    class << self
      def endpoint(uri, &blk)
        @endpoints = {} if @endpoints.nil?

        @endpoints[uri.to_s] =
          if @endpoints[uri.to_s].nil?
            Endpoint.new(uri, &blk)
          else
            @endpoints[uri.to_s].merge(&blk)
          end
      end

      def data
        @endpoints
      end
    end
  end
end