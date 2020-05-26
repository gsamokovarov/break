# frozen_string_literal: true

require "test_helper"

module Break
  class TracePointCommandTest < Test
    test "leaves off the delayed fiber execution in remote sessions" do
      command, session = testing_command do |trace, *|
        trace.disable
        context!(*context.bindings[0...-1], trace.binding)
      end

      local_var_for_current_binding = true

      Thread.new do
        command.execute_trace trace(:line, disable: nil, binding: -> { Kernel.binding })
      end.join

      assert_includes session.context.binding.local_variables, :local_var_for_current_binding
    end

    def testing_command(binding = Kernel.binding, &block)
      command_class = Class.new(TracePointCommand) do
        define_method(:execute_trace, &block)
      end

      session = Session.new(binding, frontend: TestingFrontend.new)

      [command_class.new(session), session]
    end

    def trace(event, **methods)
      trace = Object.new
      trace.define_singleton_method(:event) { event }
      methods.each do |name, implementation|
        implementation = -> { implementation } unless implementation.respond_to?(:call)
        trace.define_singleton_method(name, &implementation)
      end
      trace
    end
  end
end
