# frozen_string_literal: true

require "pathname"

module Break::IRB
  class Commands < Module
    def initialize(session)
      define_command session, :next,     Break::NextCommand
      define_command session, :step,     Break::StepCommand
      define_command session, :up,       Break::UpCommand
      define_command session, :down,     Break::DownCommand
      define_command session, :list,     Break::ListCommand
      define_command session, :continue, Break::ContinueCommand, preserve: false
    end

    private

    def define_command(session, name, cls, preserve: true)
      define_method(name) do |*args|
        cls.new(session).execute(*args)
      ensure
        # We don't have a clear guideline of when an IRB session starts and
        # when it ends. If we're executing commands, we have to quit the IRB
        # session which naturally marks it as stopped. If we're executing a
        # `break` command we actually want to keep marking it as started
        # so we don't step over `binding.irb` calls.
        Break::Session.start! if preserve
      end
    end
  end
end
