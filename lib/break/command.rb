# frozen_string_literal: true

require "forwardable"

module Break
  class Command
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
