# frozen_string_literal: true

require "irb"

module Break::IRB
  class Frontend
    def initialize
      IRB.setup caller_locations.first.path, argv: []
    end

    def attach(session)
      @workspace = IRB::WorkSpace.new(session.context.binding)
      @irb = safetely_build_irb_instance(session, @workspace)

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
      def irb_context.evaluate(line, line_no, *args, **kwargs)
        line = "self.next\n" if line == "next\n"
        super(line, line_no, *args, **kwargs)
      end

      irb_context
    end

    # Trying to instantiate an `IRB:Irb` object with a workspace having a
    # binding coming from `BasicObject`.
    def safetely_build_irb_instance(session, workspace)
      irb = IRB::Irb.allocate
      irb.instance_variable_set :@context, IRB::Context.new(irb, workspace, nil)
      irb.instance_variable_set :@signal_status, :IN_IRB
      irb.instance_variable_set :@scanner, RubyLex.new

      begin
        irb.context.main.extend IRB::ExtendCommandBundle
      rescue NameError, TypeError
        # Potential `NameError`: undefined method `irb_print_working_workspace' for class `#<Class:#420>'.
        # Ignore it.
      end

      irb.context.main.extend Commands.new(session)
      irb
    end
  end
end
