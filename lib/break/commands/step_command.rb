# frozen_string_literal: true

module Break
  class StepCommand < TracePointCommand
    trace :line, :call, :return, :class, :end, :b_call, :b_return

    def execute_trace(trace, *)
      case trace.event
      when :call, :class, :b_call
        trace.disable

        context!(*context.bindings, trace.binding)
      when :return, :end, :b_return
        context.bindings.pop
        context.depth -= 1
      when :line
        return if context.depth.positive?

        trace.disable

        context!(*context.bindings[0...-1], trace.binding)
      end
    end
  end
end
