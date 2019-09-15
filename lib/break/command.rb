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
