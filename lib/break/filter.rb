require "irb"

module Break
  module Filter extend self
    attr_reader :internal

    @internal = [
      IRB.method(:start).source_location.first.chomp(".rb"),
      "(irb)",
      __dir__,
    ]

    def internal?(path)
      @internal.any? { |location| path.include?(location) }
    end
  end
end
