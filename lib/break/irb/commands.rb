# frozen_string_literal: true

require "pathname"

module Break::IRB
  class Commands < Module
    def initialize(session)
      Break::Command.commands.each do |command_class|
        define_command command_class, session
      end
    end

    private

    def define_command(command_class, session)
      define_method(command_class.name) do |*args|
        command_class.new(session).execute(*args)
      ensure
        # We don't have a clear guideline of when an IRB session starts and
        # when it ends. If we're excuting commands, we have to quit the IRB
        # session which naturally marks it as stopped. If we're executing a
        # `break` command though we actually want to keep marking it as started
        # so we don't step over `binding.irb` calls.
        Break::Session.start! unless command_class == Break::ContinueCommand
      end

      command_class.aliases.each do |alias_name|
        alias_method alias_name, command_class.name
      end
    end
  end
end
