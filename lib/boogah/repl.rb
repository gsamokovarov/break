require "irb"

module Boogah
  class REPL
    def initialize(binding)
      IRB.setup(caller_locations.first.path, argv: [])

      @binding = binding
      @workspace = IRB::WorkSpace.new(@binding)
      @irb = IRB::Irb.new(@workspace)
    end

    def start(inspector)
      @binding.receiver.singleton_class.prepend(Commands.new(inspector))
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
