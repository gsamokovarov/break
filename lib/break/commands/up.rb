command :up, short: :u do
  unless current.frames[current.depth - 2]
    next puts "Cannot go further up the stack"
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    context = Context.new(*current.frames, depth: current.depth - 1)
    context.start
  end

  current.stop
end
