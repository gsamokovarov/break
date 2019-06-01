require "irb"

module Break
  class Frontend
    def initialize
      IRB.setup caller_locations.first.path, argv: %w(--prompt=simple)
    end

    def attach(session)
      session.context.current_frame.receiver.singleton_class.prepend(Commands.new(session))

      @workspace = IRB::WorkSpace.new(session.context.current_frame)
      @irb = IRB::Irb.new(@workspace)

      where
      @irb.run(IRB.conf)
    end

    def detach
      @irb&.context.exit
    end

    def where
      puts @workspace&.code_around_binding
    end

    def notify(message)
      puts message
    end
  end
end
