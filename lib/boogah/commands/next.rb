command :next, short: :n do
  TracePoint.trace(:line) do |trace|
    next unless current.path == trace.path
    next unless trace.lineno == current.lineno + 1

    trace.disable

    inspector = Inspector.new(trace.binding)
    inspector.start
  end

  current.stop
end
