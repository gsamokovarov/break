command :up, short: :u do
  unless current.frames[current.depth - 2]
    next current.frontend.notify("Cannot go further up the stack")
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    context = Context.new(*current.frames, depth: current.depth - 1, frontend_class: current.frontend_class)
    context.start
  end

  current.stop
end
