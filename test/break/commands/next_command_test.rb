# frozen_string_literal: true

require "test_helper"

module Break
  class NextCommandsTest < Test
    test "increments the debugging context depth on :call, :class and :b_call events" do
      command, session = next_command

      command.execute_trace trace(:call, binding: nil)
      command.execute_trace trace(:class, binding: nil)
      command.execute_trace trace(:b_call, binding: nil)

      assert_equal 3, session.context.depth
    end

    test "decrements the debugging context depth on :return, :end and :b_return events" do
      command, session = next_command

      command.execute_trace trace(:return, binding: nil)
      command.execute_trace trace(:end, binding: nil)
      command.execute_trace trace(:b_return, binding: nil)

      assert_equal(-3, session.context.depth)
    end

    test "disables the current tracing on each step over" do
      command, session = next_command

      disabled = false
      command.execute_trace trace(:line, binding: nil, disable: -> { disabled = true })

      assert disabled
    end

    test "disables the current tracing on each step over" do
      command, = next_command

      disabled = false
      command.execute_trace trace(:line, binding: nil, disable: -> { disabled = true })

      assert disabled
    end

    test "creates new debugging context on zero or negative depth" do
      command, session = next_command

      # This is a common case – step-into a one-line method and then step-over.
      command.execute_trace trace(:return, binding: nil)
      command.execute_trace trace(:line, disable: nil, binding: -> { Kernel.binding })

      assert_equal __LINE__ - 2, session.context.binding.source_location.last
    end

    def next_command
      session = Session.new(binding, frontend: TestingFrontend.new)

      [NextCommand.new(session), session]
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
