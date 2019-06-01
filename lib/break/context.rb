module Break
  class Context
    attr_accessor :frames
    attr_accessor :depth

    attr_reader :frontend_class
    attr_reader :frontend

    def initialize(*frames, depth: 0, frontend_class: Frontend)
      @frames = frames
      @depth = depth

      @frontend_class = frontend_class
      @frontend = frontend_class.new(current_binding)
    end

    def start
      @frontend.attach(self)
    end

    def stop
      @frontend.detach
    end

    def path
      current_binding.source_location.first
    end

    def lineno
      current_binding.source_location.last
    end

    def inspect
      "#{path}:#{lineno}"
    end

    private

    def current_binding
      @frames[@depth - 1]
    end
  end
end
