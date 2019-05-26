require "irb"

module Break
  class Frontend
    def initialize(binding)
      IRB.setup caller_locations.first.path, argv: %w(--prompt=simple)

      @binding = binding
      @workspace = IRB::WorkSpace.new(@binding)
      @irb = IRB::Irb.new(@workspace)
    end

    def attach(context)
      where

      @binding.receiver.singleton_class.prepend(Commands.new(context))
      @irb.run(IRB.conf)
    end

    def detach
      @irb.context.exit
    end

    def where
      puts @workspace.code_around_binding
    end

    def notify(message)
      puts message
    end
  end
end
