# frozen_string_literal: true

command :next, short: :n do
  TracePoint.trace(:line, :call, :return, :class, :end) do |trace|
    next if Filter.internal?(trace.path)

    case trace.event
    when :call, :class
      current.context.bindings << trace.binding
      current.context.depth += 1
    when :return, :end
      current.context.bindings.pop
      current.context.depth -= 1
    when :line
      next if current.context.depth.positive?

      trace.disable

      current.context!(*current.context.bindings[0...-1], trace.binding)
    end
  end

  current.leave
end
