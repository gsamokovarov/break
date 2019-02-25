module Booger
  class Commands < Module
    def initialize(current)
      command :next, short: :n do
        TracePoint.trace(:line) do |trace|
          next unless current.path == trace.path
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

      command :step, short: :s do
        TracePoint.trace(:call, :line) do |trace|
          case trace.event
          when :line
            next unless current.path == trace.path
            next unless [current.lineno, current.lineno + 1].include?(trace.lineno)
          when :call
            caller = trace.self.send(:caller_locations)[1]

            next unless caller
            next unless current.path == caller.path
            next unless [current.lineno, current.lineno + 1].include?(caller.lineno)
          end

          trace.disable

          inspector = Inspector.new(trace.binding)
          inspector.start
        end

        current.stop
      end
    end

    def command(name, short: nil, &block)
      define_method(name, &block)
      alias_method short, name if short
    end
  end
end
