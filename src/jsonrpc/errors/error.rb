# frozen_string_literal: true

require 'hashie/mash'

module RPC
  class Error < StandardError
    attr_reader :code, :message, :data

    def initialize(code, message, data)
      @code = code
      @message = message
      @data = data
    end

    def to_mash
      Hashie::Mash.new(
        code: @code,
        message: @message,
        data: @data
      )
    end
  end
end
