module RPC
  class Namespace
    attr_reader :name, :namespaces, :functions

    def initialize(name, &blk)
      @name = name

      @namespaces = {}
      @functions = {}

      instance_eval(&blk)
    end

    def namespace(name, &blk)
      @namespaces[name.to_s] =
        if @namespaces[name.to_s].nil?
          Namespace.new(name, &blk)
        else
          @namespaces[name.to_s].merge(&blk)
        end
    end

    def fun(name, &blk)
      @functions[name.to_s] = blk
    end

    def merge(&blk)
      instance_eval(&blk)
    end
  end
end