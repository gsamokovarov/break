module Break
  class Context
    attr_accessor :frames
    attr_accessor :depth

    def initialize(*frames, depth: 0)
      @frames = frames
      @depth = depth
    end

    def current_frame
      @frames[@depth - 1]
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
  end
end
