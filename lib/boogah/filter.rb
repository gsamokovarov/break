require "irb"

module Boogah
  module Filter extend self
    IRB_LOCATION = IRB.method(:start).source_location.first.chomp(".rb")
    IRB_MAGIC_LOCATION = "(irb)"
    BOOGAH_LOCATION = __dir__

    def internal?(path)
      path.include?(IRB_LOCATION) ||
        path.include?(IRB_MAGIC_LOCATION) ||
        path.include?(BOOGAH_LOCATION)
    end

    def next_to?(current, target)
      current.path == target.path &&
        [current.lineno, current.lineno + 1].include?(target.lineno)
    end
  end
end
