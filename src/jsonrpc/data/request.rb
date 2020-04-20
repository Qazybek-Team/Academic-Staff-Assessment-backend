# frozen_string_literal: true

require_relative '../errors'
require_relative 'func_path'

module RPC
  class Request
    class << self
      def from_mash(mash)
        validate mash

        new mash.id, mash['method'], mash.params
      end

      private

      def validate(mash)
        unless mash.jsonrpc == '2.0'
          raise RequestError.invalid_version mash.jsonrpc
        end

        validate_id mash.id
        validate_method mash['method']
      end

      def validate_id(id)
        raise RequestError.missing_id if id.nil?

        unless id.is_a?(String) or id.is_a?(Numeric)
          raise RequestError.invalid_id id.class
        end
      end

      def validate_method(method)
        raise RequestError.missing_method if method.nil?

        unless method.is_a? String
          raise RequestError.invalid_method method.class
        end
      end
    end

    attr_reader :id, :method, :params

    def initialize(id, method, params)
      @id = id
      @method = parse_method_name method
      @params = params
    end

    private

    def parse_method_name(method)
      FuncPath.new method.to_s.split('.')
    end
  end
end
