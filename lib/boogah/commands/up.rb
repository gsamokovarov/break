command :up do
  unless current.frames.size > 1
    next puts "Cannot go up the stack"
  end

  TracePoint.trace do |trace|
    next if Filter.internal?(trace.path)

    trace.disable

    context = Context.new(current.frames[0...-1])
    context.start
  end

  current.stop
end
