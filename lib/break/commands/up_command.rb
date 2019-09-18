# frozen_string_literal: true

module Break
  class UpCommand < TracePointCommand
    def execute(*)
      if context.bindings[context.depth - 2]
        super
      else
        frontend.notify("Cannot go further up the stack")
      end
    end

    def execute_trace(trace, *)
      trace.disable

      context!(*context.bindings, depth: context.depth - 1)
    end
  end
end
