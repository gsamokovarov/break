require "pathname"

module Break
  class Commands < Module
    def self.execute(context, command, *args)
      obj = Object.new
      obj.extend Commands.new(context)
      obj.public_send(command, *args)
    end

    def initialize(current)
      Dir.each_child current_directory.join("commands") do |cmd|
        require_command { "commands/#{cmd}" }
      end
    end

    def command(name, short: nil, &block)
      define_method(name, &block)
      alias_method short, name if short
    end

    private

    def require_command(&block)
      filename = block.call
      filename += ".rb" unless filename.end_with?(".rb")
      filepath = current_directory.join(filename)

      block.binding.eval filepath.read, filepath.to_s, 1
    end

    def current_directory
      Pathname.new(__dir__)
    end
  end
end
