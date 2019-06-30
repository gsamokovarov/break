# frozen_string_literal: true

module Pry::Break
  Commands = Pry::CommandSet.new do
    create_command "next", "Go to the next line." do

      banner <<-BANNER
        Usage: next
        Step over within the same frame. Examples:
          next #=> Move a line forward.
      BANNER

      def process
        frontend = Pry::Break::Frontend.new(_pry_)
        session = ::Break::Session.new(_pry_.binding_stack.first, frontend: frontend)

        session.execute :next
      end
    end

    create_command "step", "Step into the current line invocation." do
      banner <<-BANNER
        Usage: step
        Step into a method call. Examples:
          step #=> Step into the method invocation.
      BANNER

      def process
        frontend = Pry::Break::Frontend.new(_pry_)
        session = ::Break::Session.new(_pry_.binding_stack.first, frontend: frontend)

        session.execute :step
      end
    end
  end
end
