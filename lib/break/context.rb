# frozen_string_literal: true

module Break
  class Context
    attr_accessor :bindings
    attr_accessor :depth

    def initialize(*bindings, depth: 0)
      @bindings = bindings
      @depth = depth
    end

    def binding
      @bindings[@depth - 1]
    end

    def inspect
      "#{path}:#{lineno}"
    end
  end
end
