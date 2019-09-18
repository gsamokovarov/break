# frozen_string_literal: true

require "forwardable"

module Break
  class Command
    class << self
      attr_reader :name, :aliases

      def command(name, aliases: [])
        @name = name
        @aliases = Array(aliases)
      end

      def commands
        @commands ||= []
      end
    end

    extend Forwardable

    def initialize(session)
      @session = session
    end

    def execute
      raise NotImplementedError
    end

    private

    attr_reader :session
    def_delegators :session, :context, :context!, :frontend
  end
end

require_relative "commands/tracepoint_command"

require_relative "commands/continue_command"
Break::Command.commands << Break::ContinueCommand

require_relative "commands/list_command"
Break::Command.commands << Break::ListCommand

require_relative "commands/next_command"
Break::Command.commands << Break::NextCommand

require_relative "commands/step_command"
Break::Command.commands << Break::StepCommand

require_relative "commands/up_command"
Break::Command.commands << Break::UpCommand

require_relative "commands/down_command"
Break::Command.commands << Break::DownCommand
