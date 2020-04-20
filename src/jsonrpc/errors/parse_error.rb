# frozen_string_literal: true

require_relative 'error'

module RPC
  class ParseError < RPC::Error
    def initialize(data = '')
      super(-32_700, 'Parse error', data)
    end
  end
end
