module Booger
  class Inspector
    def initialize(binding)
      @binding = binding
      @repl = REPL.new(@binding)
    end

    def start
      @repl.start(self)
    end

    def stop
      @repl.stop
    end

    def path
      @binding.source_location.first
    end

    def lineno
      @binding.source_location.last
    end
  end
end
