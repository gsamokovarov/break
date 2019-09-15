# frozen_string_literal: true

require "pathname"

require_relative "commands/tracepoint_command"
require_relative "commands/continue_command"
require_relative "commands/down_command"
require_relative "commands/list_command"
require_relative "commands/next_command"
require_relative "commands/step_command"
require_relative "commands/up_command"

module Break
  class Commands < Module
    def self.execute(session, command, *args)
      obj = Object.new
      obj.extend Commands.new(session)
      obj.public_send(command, *args)
    end

    def initialize(session)
      define_command ContinueCommand, session
      define_command NextCommand,     session
      define_command StepCommand,     session
      define_command UpCommand,       session
      define_command DownCommand,     session
    end

    private

    def define_command(command_class, session)
      define_method(command_class.name) do |*args|
        command_class.new(session).execute(*args)
      end

      command_class.aliases.each do |alias_name|
        alias_method alias_name, command_class.name
      end
    end
  end
end
