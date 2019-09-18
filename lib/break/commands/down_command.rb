# frozen_string_literal: true

module Break
  class DownCommand < TracePointCommand
    def execute(*)
      if context.depth >= 0
        frontend.notify("Cannot go further down the stack")
      else
        super
      end
    end

    def execute_trace(trace, *)
      trace.disable

      context!(*context.bindings, depth: context.depth + 1)
    end
  end
end
