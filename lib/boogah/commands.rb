require "pathname"

module Boogah
  class Commands < Module
    def initialize(current)
      require_command { "commands/next" }
      require_command { "commands/step" }
      require_command { "commands/up" }
      require_command { "commands/continue" }
      require_command { "commands/list" }
    end

    def command(name, short: nil, &block)
      define_method(name, &block)
      alias_method short, name if short
    end

    def require_command(&block)
      filename = block.call
      filename += ".rb" unless filename.end_with?(".rb")

      block.binding.eval(Pathname.new(__dir__).join(filename).read)
    end
  end
end
