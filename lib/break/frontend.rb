# frozen_string_literal: true

require "irb"

module Break
  class Frontend
    def initialize
      IRB.setup caller_locations.first.path, argv: []
    end

    def attach(session)
      begin
        session.context.binding.receiver.singleton_class.prepend(Commands.new(session))
      rescue TypeError
        return
      end

      @workspace = IRB::WorkSpace.new(session.context.binding)
      @irb = IRB::Irb.new(@workspace)

      where
      @irb.run(IRB.conf)
    end

    def detach
      @irb&.context&.exit
    end

    def where
      puts @workspace&.code_around_binding
    end

    def notify(message)
      puts message
    end
  end
end
