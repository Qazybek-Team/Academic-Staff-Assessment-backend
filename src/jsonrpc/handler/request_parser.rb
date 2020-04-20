# frozen_string_literal: true

require 'multi_json'

require_relative '../util/mash'
require_relative '../errors'
require_relative '../data/request'

module RPC
  module RequestParser
    protected

    # @param [String] string
    # @return [Array<Hash>]
    def preparse_requests(string)
      data = MultiJson.load string

      if data.is_a? Hash or data.is_a? Array
        data
      else
        raise RequestError.invalid_body(data.class)
      end
    rescue MultiJson::ParseError => e
      raise ParseError, e.message
    end

    def parse_request(hash)
      raise RequestError.invalid_body(hash.class) unless hash.is_a? Hash

      mash = Mash.deep hash

      Request.from_mash mash
    end
  end
end
