command :down, short: :d do
  if current.depth >= 0
    next puts "Cannot go further down the stack"
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    context = Context.new(*current.frames, depth: current.depth + 1)
    context.start
  end

  current.stop
end
