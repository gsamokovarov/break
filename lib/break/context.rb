module Break
  class Context
    attr_accessor :frames
    attr_accessor :depth

    def initialize(*frames, depth: 0)
      @frames = frames
      @depth = depth

      @frontend = Frontend.new(current_binding)
    end

    def start
      puts code_extract
      @frontend.start(self)
    end

    def stop
      @frontend.stop
    end

    def code_extract
      @frontend.code_extract
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
