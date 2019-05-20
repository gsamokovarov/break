require "irb"

module Break
  class Frontend
    def initialize(binding)
      IRB.setup caller_locations.first.path, argv: %w(--prompt=simple)

      @binding = binding
      @workspace = IRB::WorkSpace.new(@binding)
      @irb = IRB::Irb.new(@workspace)
    end

    def start(context)
      puts code_extract
      @binding.receiver.singleton_class.prepend(Commands.new(context))
      @irb.run(IRB.conf)
    end

    def stop
      @irb.context.exit
    end

    def code_extract
      @workspace.code_around_binding
    end
  end
end
