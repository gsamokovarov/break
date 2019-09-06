# frozen_string_literal: true

command :down, short: :d do
  if current.context.depth >= 0
    next current.frontend.notify("Cannot go further down the stack")
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    current.context!(*current.context.bindings, depth: current.context.depth + 1)
  end

  current.leave
end
