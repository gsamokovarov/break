# frozen_string_literal: true

require "irb"

module Break::IRB
  class Frontend
    def initialize
      IRB.setup caller_locations.first.path, argv: []
    end

    def attach(session)
      @workspace = IRB::WorkSpace.new(session.context.binding)

      begin
        @irb = IRB::Irb.new(@workspace)
        @irb.context.main.extend Commands.new(session)
      rescue TypeError
        return
      end

      where

      @irb.suspend_context special_case_next_eval(@irb.context) do
        @irb.run(IRB.conf)
      end
    end

    def detach
      @irb&.context&.exit
    end

    def where
      puts @workspace.code_around_binding if @workspace
    end

    def notify(message)
      puts message
    end

    private

    # Evaling `next` is a `SyntaxError` in Ruby. Since IRB does not have
    # commands support in the lexer level, we need to call the `next` command
    # in syntactically correct way.
    def special_case_next_eval(irb_context)
      def irb_context.evaluate(line, line_no, exception: nil)
        line = "self.next\n" if line == "next\n"
        super(line, line_no, exception: exception)
      end

      irb_context
    end
  end
end
