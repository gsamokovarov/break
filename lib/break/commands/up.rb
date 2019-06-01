command :up, short: :u do
  unless current.context.bindings[current.context.depth - 2]
    next current.frontend.notify("Cannot go further up the stack")
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    current.context!(*current.context.bindings, depth: current.context.depth - 1)
  end

  current.leave
end
