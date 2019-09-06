# frozen_string_literal: true

module Break
  module Filter
    extend self

    attr_reader :internal

    def register_internal(*paths)
      (@internal ||= []).concat(paths)
    end

    def internal?(path)
      @internal.any? { |location| path.include?(location) }
    end
  end
end
