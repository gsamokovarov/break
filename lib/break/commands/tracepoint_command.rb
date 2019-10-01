# frozen_string_literal: true

module Break
  class TracePointCommand < Command
    class << self
      attr_reader :trace_events

      def trace(*events)
        @trace_events = events
      end
    end

    def initialize(*)
      super

      @delayed_context = Fiber.new do |*args|
        session.context!(*args)

        loop do
          session.context!(*Fiber.yield)
        end
      end
    end

    def execute(*args)
      TracePoint.trace(*trace_events) do |trace|
        next if Filter.internal?(trace.path)

        execute_trace(trace, *args)
      end

      session.leave
    end

    def execute_trace
      raise NotImplementedError
    end

    private

    def context!(*args)
      @delayed_context.resume(*args)
    end

    def trace_events
      self.class.trace_events
    end
  end
end
