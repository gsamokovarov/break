module Boogah
  class Context
    def initialize(binding)
      @binding = binding
      @repl = REPL.new(@binding)
    end

    def start
      puts code_extract
      @repl.start(self)
    end

    def stop
      @repl.stop
    end

    def code_extract
      @repl.code_extract
    end

    def path
      @binding.source_location.first
    end

    def lineno
      @binding.source_location.last
    end

    def inspect
      "#{path}:#{lineno}"
    end
  end
end
