# frozen_string_literal: true

require_relative 'error'

module RPC
  class ArgumentError < Error
    def initialize(data)
      super(-32_602, 'Invalid params', data)
    end
  end
end
