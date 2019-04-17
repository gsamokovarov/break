command :step, short: :s do
  TracePoint.trace(:line, :call, :return, :class, :end) do |trace|
    next if Filter.internal?(trace.path)

    case trace.event
    when :call, :class
      trace.disable

      context = Context.new(*current.frames, trace.binding)
      context.start
    when :return, :end
      current.frames.pop
      current.depth -= 1
    when :line
      next if current.depth.positive?
      next if current.valid? && Filter.same_line?(current, trace)

      trace.disable

      context = Context.new(*current.frames[0...-1], trace.binding)
      context.start
    end
  end

  current.stop
end
