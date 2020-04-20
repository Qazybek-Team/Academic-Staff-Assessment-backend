# frozen_string_literal: true

require_relative 'error'

module RPC
  class RequestError < RPC::Error
    class << self
      def invalid_version(given)
        new(
          'Invalid JSON-RPC version: ' \
               "expected '2.0', found '#{given || 'nil'}'"
        )
      end

      def missing_id
        new('Request ID is null or missing!')
      end

      def missing_method
        new('Request method is null or missing!')
      end

      def invalid_id(given_type)
        new(
          'Request ID is invalid: ' \
               "<#{given_type}> cannot be coerced into <String | Numeric>"
        )
      end

      def invalid_method(given_type)
        new(
          'Request method is invalid: ' \
               "<#{given_type}> cannot be coerced into <String>"
        )
      end

      def invalid_body(given_type)
        new(
          'Request body is invalid: ' \
               "<#{given_type}> cannot be coerced to <Array | Object>"
        )
      end
    end

    def initialize(data = '')
      super(-32_600, 'Invalid Request', data)
    end
  end
end
