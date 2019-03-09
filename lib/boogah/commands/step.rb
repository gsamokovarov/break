command :step, short: :s do
  TracePoint.trace(:call, :line) do |trace|
    case trace.event
    when :line
      next unless current.path == trace.path
      next unless [current.lineno, current.lineno + 1].include?(trace.lineno)
    when :call
      caller = trace.self.send(:caller_locations)[1]

      next unless caller
      next unless current.path == caller.path
      next unless [current.lineno, current.lineno + 1].include?(caller.lineno)
    end

    trace.disable

    inspector = Inspector.new(trace.binding)
    inspector.start
  end

  current.stop
end
