# frozen_string_literal: true

module Break
  class Session
    class << self
      def start!
        Thread.current[:__break_active_session__] = true
      end

      def stop!
        Thread.current[:__break_active_session__] = nil
      end

      def active?
        Thread.current[:__break_active_session__]
      end
    end

    attr_reader :contexts
    attr_reader :frontend

    def initialize(binding, frontend:)
      @contexts = [Context.new(binding)]
      @frontend = frontend
    end

    def enter
      frontend.attach(self)
    end

    def leave
      frontend.detach
    end

    def context
      contexts.last
    end

    def context!(*bindings, depth: 0)
      contexts << Context.new(*bindings, depth: depth)
      enter
    end
  end
end
