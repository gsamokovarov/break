# frozen_string_literal: true

module Break
  class StepCommand < TracePointCommand
    command :step, aliases: :s

    trace :line, :call, :return, :class, :end

    def execute_trace(trace, *)
      case trace.event
      when :call, :class
        trace.disable

        context!(*context.bindings, trace.binding)
      when :return, :end
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
