require "pathname"

module Boogah
  class Commands < Module
    def initialize(current)
      Dir.each_child current_directory.join("commands") do |cmd|
        require_command { "commands/#{cmd}" }
      end
    end

    def command(name, short: nil, &block)
      define_method(name, &block)
      alias_method short, name if short
    end

    def require_command(&block)
      filename = block.call
      filename += ".rb" unless filename.end_with?(".rb")

      block.binding.eval(current_directory.join(filename).read)
    end

    private

    def current_directory
      Pathname.new(__dir__)
    end
  end
end
