# frozen_string_literal: true

require_relative 'response'

module RPC
  class SuccessResponse < Response
    def initialize(id, result)
      super(id, nil, result)
    end
  end
end
