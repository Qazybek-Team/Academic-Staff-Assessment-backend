# frozen_string_literal: true

require_relative 'error'

module RPC
  class FuncNotNsError < RPC::Error
    def initialize(ns_name, child_ns_name)
      super(
        -32_601,
        'Method not found',
        "Namespace '#{child_ns_name}' not found in '#{ns_name}', " \
             'found func instead!'
      )
    end
  end
end
