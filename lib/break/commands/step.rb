command :step, short: :s do
  TracePoint.trace(:line, :call, :return, :class, :end) do |trace|
    next if Filter.internal?(trace.path)

    case trace.event
    when :call, :class
      trace.disable

      context = Context.new(*current.frames, trace.binding, frontend: current.frontend.class)
      context.start
    when :return, :end
      current.frames.pop
      current.depth -= 1
    when :line
      next if current.depth.positive?

      trace.disable

      context = Context.new(*current.frames[0...-1], trace.binding, frontend: current.frontend.class)
      context.start
    end
  end

  current.stop
end
