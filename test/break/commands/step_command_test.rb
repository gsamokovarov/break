# frozen_string_literal: true

require "test_helper"

module Break
  class StepCommandsTest < Test
    test "steps into :call, :class and :b_call events" do
      command, session = step_command

      command.execute_trace trace(:call, disable: nil, binding: -> { Kernel.binding })
      assert_equal __LINE__ - 1, session.context.binding.source_location.last

      command.execute_trace trace(:class, disable: nil, binding: -> { Kernel.binding })
      assert_equal __LINE__ - 1, session.context.binding.source_location.last

      command.execute_trace trace(:b_call, disable: nil, binding: -> { Kernel.binding })
      assert_equal __LINE__ - 1, session.context.binding.source_location.last
    end

    test "decrements the debugging context depth on :return, :end and :b_return" do
      command, session = step_command

      command.execute_trace trace(:return, binding: binding)
      command.execute_trace trace(:end, binding: binding)
      command.execute_trace trace(:b_return, binding: binding)

      assert_equal(-3, session.context.depth)
    end

    test "acts like step-over on :line events for convenience" do
      command, session = step_command

      command.execute_trace trace(:line, disable: nil, binding: -> { Kernel.binding })

      assert_equal __LINE__ - 2, session.context.binding.source_location.last
    end

    def step_command
      session = Session.new(binding, frontend: TestingFrontend.new)

      [StepCommand.new(session), session]
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
