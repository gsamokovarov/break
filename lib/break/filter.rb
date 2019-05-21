require "irb"

module Break
  module Filter extend self
    IRB_LOCATION = IRB.method(:start).source_location.first.chomp(".rb")
    IRB_MAGIC_LOCATION = "(irb)"
    BOOGAH_LOCATION = __dir__

    def internal?(path)
      path.include?(IRB_LOCATION) ||
        path.include?(IRB_MAGIC_LOCATION) ||
        path.include?(BOOGAH_LOCATION)
    end
  end
end
