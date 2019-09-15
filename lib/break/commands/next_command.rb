# frozen_string_literal: true

module Break
  class NextCommand < TracePointCommand
    command :next, aliases: :n

    trace :line, :call, :return, :class, :end

    def execute_trace(trace, *)
      case trace.event
      when :call, :class
        context.bindings << trace.binding
        context.depth += 1
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
