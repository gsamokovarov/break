command :up, short: :u do
  unless current.context.frames[current.context.depth - 2]
    next current.frontend.notify("Cannot go further up the stack")
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    current.context!(*current.context.frames, depth: current.context.depth - 1)
  end

  current.leave
end
