require "irb"

module Booger
  class REPL
    def initialize(binding)
      IRB.setup(caller_locations.first.path, argv: [])

      @binding = binding
      @workspace = IRB::WorkSpace.new(@binding)
      @irb = IRB::Irb.new(@workspace)
    end

    def start(inspector)
      puts @workspace.code_around_binding

      @binding.receiver.singleton_class.prepend(Commands.new(inspector))
      @irb.run(IRB.conf)
    end

    def stop
      @irb.context.exit
    end
  end
end
