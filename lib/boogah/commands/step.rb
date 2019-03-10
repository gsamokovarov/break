command :step, short: :s do
  TracePoint.trace(:call, :line) do |trace|
    case trace.event
    when :line
      next if Filter.internal?(trace.path)
      next unless Filter.next_to?(current, trace)
    when :call
      next if Filter.internal?(trace.path)
      next unless caller = trace.self.send(:caller_locations)[1]
      next unless Filter.next_to?(current, caller)
    end

    trace.disable

    inspector = Inspector.new(trace.binding)
    inspector.start
  end

  current.stop
end
