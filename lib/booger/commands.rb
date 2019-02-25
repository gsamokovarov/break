module Booger
  class Commands < Module
    def initialize(current)
      command :next, short: :n do
        TracePoint.trace(:line) do |trace|
          next unless trace.lineno == current.lineno + 1

          trace.disable

          inspector = Inspector.new(trace.binding)
          inspector.start
        end

        current.stop
      end

      command :continue, short: :c do
        current.stop
      end

      command :list, short: :ls do
        puts current.code_extract
      end
    end

    def command(name, short: nil, &block)
      define_method(name, &block)
      alias_method short, name if short
    end
  end
end
