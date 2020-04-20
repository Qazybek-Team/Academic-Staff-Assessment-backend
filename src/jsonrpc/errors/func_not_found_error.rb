# frozen_string_literal: true

require_relative 'error'

module RPC
  class FuncNotFoundError < RPC::Error
    def initialize(ns_name, func_name)
      super(
        -32_601,
        'Method not found',
        "Method '#{func_name}' not found in '#{ns_name}'"
      )
    end
  end
end
