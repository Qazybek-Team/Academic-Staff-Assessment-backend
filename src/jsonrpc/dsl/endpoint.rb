require_relative 'namespace'

module RPC
  class Endpoint < Namespace
    attr_reader :uri

    def initialize(uri, &blk)
      super(nil)

      @uri = uri
    end
  end
end