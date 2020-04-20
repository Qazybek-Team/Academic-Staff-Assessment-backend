require 'active_support/core_ext/string'

module RPC
  class FuncPath
    attr_reader :func, :namespaces

    def initialize(fragments)
      fragments = fragments.map(&:underscore)
      @func = fragments.pop
      @namespaces = fragments
    end

    def shift
      return nil if @namespaces.empty?

      @namespaces.shift
    end
  end
end