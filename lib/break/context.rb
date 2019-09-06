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

    def path
      current_binding.source_location.first
    end

    def lineno
      current_binding.source_location.last
    end

    def inspect
      "#{path}:#{lineno}"
    end
  end
end
