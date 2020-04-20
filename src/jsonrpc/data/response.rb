# frozen_string_literal: true

require_relative '../util/mash'

module RPC
  class Response
    attr_reader :id, :error, :result

    def to_mash
      Mash.deep(
        id: @id,
        error: @error&.to_mash,
        result: @result
      )
    end

    protected

    def initialize(id, error, result)
      @jsonrpc = '2.0'
      @id = id
      @error = error
      @result = result
    end
  end
end

require_relative 'success_response'
require_relative 'error_response'
