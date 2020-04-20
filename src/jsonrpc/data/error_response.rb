# frozen_string_literal: true

require_relative 'response'

module RPC
  class ErrorResponse < Response
    def initialize(id, error)
      super(id, error, nil)
    end
  end
end
