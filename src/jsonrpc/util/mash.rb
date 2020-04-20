# frozen_string_literal: true

require 'ostruct'

module RPC
  class Mash < ::OpenStruct
    class << self
      def deep(obj)
        return deep_array(obj) if obj.is_a? Array
        return obj unless obj.is_a? Hash

        conv_obj = obj.map do |key, value|
          [key, deep(value)]
        end.to_h

        new conv_obj
      end

      private

      def deep_array(ary)
        ary.map do |obj|
          deep obj
        end
      end
    end

    def to_hash
      to_h do |key, value|
        if value.is_a? self.class
          [key, value.to_hash]
        else
          [key, value]
        end
      end
    end

    def keys
      to_h.keys
    end
  end
end
