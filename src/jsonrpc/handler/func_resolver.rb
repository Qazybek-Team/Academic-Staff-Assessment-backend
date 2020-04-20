# frozen_string_literal: true

require_relative '../data/func_path'
require_relative '../errors'

module RPC
  module FuncResolver
    @func_resolver_cache = {}

    protected

    def resolve_func(resolve_map, method_path)
      unless method_path.is_a? FuncPath
        raise ArgumentError,
              "Cannot coerce <#{method_path.class}> to <#{FuncPath}>"
      end

      current_namespace = resolve_map

      parent_ns_name = '#global'

      loop do
        ns_name = method_path.shift

        break if ns_name.nil?

        next_namespace = current_namespace[ns_name]

        validate_ns next_namespace, parent_ns_name, ns_name

        parent_ns_name = ns_name
        current_namespace = next_namespace
      end

      func = current_namespace[method_path.func]

      if func.nil?
        raise FuncNotFoundError.new(parent_ns_name, method_path.func)
      end

      func
    end

    private

    def validate_ns(ns, parent_ns_name, ns_name)
      if ns.nil?
        raise NsNotFoundError.new(parent_ns_name, ns_name)
      end

      if ns.is_a? Proc
        raise FuncNotNsError.new(parent_ns_name, ns_name)
      end
    end
  end
end
