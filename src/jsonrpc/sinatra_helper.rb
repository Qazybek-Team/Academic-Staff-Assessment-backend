# frozen_string_literal: true

require_relative 'handler/request_handler'

module RPC
  DUMMY_LOGGER = Logger.new(STDOUT, level: Logger::UNKNOWN)

  module SinatraHelper
    # @param [Class] environment
    # @param [Logger] access_logger
    # @param [Logger] error_logger
    def register_environment(
      environment,
      access_logger: DUMMY_LOGGER,
      error_logger: DUMMY_LOGGER
    )
      handler = RequestHandler.new(
        environment, access_logger, error_logger
      )

      handler.endpoints.each do |endpoint|
        instance_eval do
          post endpoint.to_s do
            handler.handle_request endpoint, env
          end
        end
      end
    end
  end
end
