command :next, short: :n do
  TracePoint.trace(:line) do |trace|
    next if Filter.internal?(trace.path)
    next unless Filter.next_to?(current, trace)

    trace.disable

    inspector = Inspector.new(trace.binding)
    inspector.start
  end

  current.stop
end
