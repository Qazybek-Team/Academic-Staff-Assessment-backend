# frozen_string_literal: true

require_relative 'dsl_parser'
require_relative 'func_resolver'
require_relative 'request_parser'
require_relative '../data/response'

module RPC
  class RequestHandler
    include DSLParser
    include FuncResolver
    include RequestParser

    # @param [Class] environment
    # @param [Logger] logger
    def initialize(environment, access_logger, error_logger)
      @resolver_map = parse_environment environment
      @access_logger = access_logger
      @error_logger = error_logger
    end

    def endpoints
      @resolver_map.keys
    end

    def handle_request(endpoint, env)
      responses = handle_request_internal endpoint, env

      MultiJson.dump responses
    end

    private

    def handle_request_internal(endpoint, env)
      request = Rack::Request.new(env)

      pp env

      @access_logger.info 'RPC' do
        request_lined = request.split(/[\r\n]+/)
                               .map { |line| "  #{line}" }
                               .join("\n")

        "from #{env['REMOTE_ADDR']}: requested:\n  #{request_lined}"
      end

      requests = preparse_requests request.body

      if requests.is_a?(Hash)
        handle_single_request(endpoint, requests)
          .to_mash
          .to_hash
      else
        requests
          .map { |r| handle_single_request(endpoint, r) }
          .map(&:to_mash)
          .map(&:to_hash)
      end
    rescue Error => e
      @error_logger.warn 'RPC' do
        "request(#global): user-failed: #{e}"
      end

      ErrorResponse.new('#global', e)
                   .to_mash.to_hash
    rescue StandardError => e
      @error_logger.error 'RPC' do
        backtrace = e.backtrace.map { |line| "  #{line}" }.join("\n")
        "request(#global): failed: #{e}\n#{backtrace}"
      end

      ErrorResponse.new('#global', InternalError.new(e.message))
                   .to_mash.to_hash
    end

    # @param [String] endpoint
    # @param [Hash] request
    def handle_single_request(endpoint, request)
      # @type [RPC::Request]
      request = parse_request request

      func = resolve_func @resolver_map[endpoint], request.method

      response = func.call request.params

      SuccessResponse.new(request.id, response)
    rescue Error => e
      rq_id = request.is_a?(Hash) ? (request['id'] || request[:id]) : request.id

      @error_logger.warn 'RPC' do
        "request(#{rq_id}): user-failed: #{e}"
      end

      ErrorResponse.new(rq_id, e)
    rescue StandardError => e
      rq_id = request.is_a?(Hash) ? (request['id'] || request[:id]) : request.id

      @error_logger.error 'RPC' do
        backtrace = e.backtrace.map { |line| "  #{line}" }.join("\n")
        "request(#{rq_id}): failed: #{e}\n#{backtrace}"
      end

      ErrorResponse.new(rq_id, InternalError.new(e.message))
    end
  end
end
