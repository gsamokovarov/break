command :next, short: :n do
  TracePoint.trace(:line, :call, :return) do |trace|
    next if Filter.internal?(trace.path)

    case trace.event
    when :call
      current.frames << trace.binding
      current.depth += 1
    when :return
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
