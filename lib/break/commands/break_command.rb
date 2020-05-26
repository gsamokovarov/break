# frozen_string_literal: true

module Break
  class BreakCommand < TracePointCommand
    trace :line

    attr_accessor :breaking_line

    def execute_trace(trace, *)
      case trace.event
      when :line
        return if breaking_line != trace.line

        trace.disable

        context!(*context.bindings[0...-1], trace.binding)
      end
    end
  end
end
