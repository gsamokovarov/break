require "irb"

module Break
  module Filter extend self
    attr_reader :internal

    def register_internal(*paths)
      (@internal ||= []).concat(paths)
    end

    def internal?(path)
      @internal.any? { |location| path.include?(location) }
    end
  end

  Filter.register_internal IRB.method(:start).source_location.first.chomp(".rb")
  Filter.register_internal "(irb)"
  Filter.register_internal __dir__
end
