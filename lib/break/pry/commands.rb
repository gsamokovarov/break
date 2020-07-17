# frozen_string_literal: true

module Break::Pry
  Commands = Pry::CommandSet.new do
    create_command "next", "Go to the next line." do
      group "Break"

      banner <<-BANNER
        Usage: next

        Step over within the same frame.

        Examples:
          next #=> Move a line forward.
      BANNER

      def process
        pry = defined?(pry_instance) ? pry_instance : _pry_
        session = Break::Session.new(pry.binding_stack.first, frontend: Frontend.new(pry))

        command = Break::NextCommand.new(session)
        command.execute
      end
    end

    create_command "step", "Step into the current line invocation." do
      group "Break"

      banner <<-BANNER
        Usage: step

        Step into a method call.

        Examples:
          step #=> Step into the method invocation.
      BANNER

      def process
        pry = defined?(pry_instance) ? pry_instance : _pry_
        session = Break::Session.new(pry.binding_stack.first, frontend: Frontend.new(pry))

        command = Break::StepCommand.new(session)
        command.execute
      end
    end

    create_command "up", "Go up a frame." do
      group "Break"

      banner <<-BANNER
        Usage: up

        Go to the frame that called the current one. Can be used only if the
        command `step` was issued before.

        Examples:
          up #=> Step into the method invocation.
      BANNER

      def process
        pry = defined?(pry_instance) ? pry_instance : _pry_
        session = Break::Session.new(pry.binding_stack.first, frontend: Frontend.new(pry))

        command = Break::UpCommand.new(session)
        command.execute
      end
    end

    create_command "down", "Go down a frame." do
      group "Break"

      banner <<-BANNER
        Usage: down

        Go to the frame called from the current one. Can be used only if the
        command `step` was issued before.

        Examples:
          down #=> Step to the previous frame.
      BANNER

      def process
        pry = defined?(pry_instance) ? pry_instance : _pry_
        session = Break::Session.new(pry.binding_stack.first, frontend: Frontend.new(pry))

        command = Break::DownCommand.new(session)
        command.execute
      end
    end
  end
end
