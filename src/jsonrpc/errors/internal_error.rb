# frozen_string_literal: true

module RPC
  class InternalError < RPC::Error
    def initialize(data)
      super(-32_603, 'Internal Error', data)
    end
  end
end
