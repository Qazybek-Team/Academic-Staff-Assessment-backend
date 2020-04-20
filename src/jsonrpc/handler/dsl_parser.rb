# frozen_string_literal: true

require_relative '../dsl/environment'
require_relative '../dsl/endpoint'
require_relative '../dsl/namespace'
require_relative '../util/mash'

module RPC
  module DSLParser

    protected

    def parse_environment(env)
      unless env.is_a? Class
        raise ::ArgumentError, "cannot coerce <#{env.class}> to <Class>"
      end
      unless env <= Environment
        raise ::ArgumentError, "<#{env}> does not inherit <#{Environment}>"
      end

      resolve_map = env.data.map do |uri, endpoint|
        [uri, parse_endpoint(endpoint)]
      end.to_h

      Mash.deep resolve_map
    end

    private

    def parse_endpoint(endpoint)
      unless endpoint.is_a? Endpoint
        raise ::ArgumentError, "cannot coerce <#{endpoint.class}> to <#{Endpoint}>"
      end

      parse_namespace(endpoint)
    end

    def parse_namespace(namespace)
      unless namespace.is_a? Namespace
        raise ::ArgumentError, "cannot coerce <#{namespace.class}> to <#{Namespace}>"
      end

      namespaces = namespace.namespaces.map do |name, ns|
        [name, parse_namespace(ns)]
      end.to_h

      namespaces.merge namespace.functions
    end
  end
end
