module Break
  class Session
    attr_reader :contexts
    attr_reader :frontend

    def initialize(binding, frontend:)
      @contexts = [Context.new(binding)]
      @frontend = frontend
    end

    def execute(command, *args)
      Commands.execute(self, command, *args)
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

    def context!(*frames, depth: 0)
      contexts << Context.new(*frames, depth: depth)
      enter
    end
  end
end
