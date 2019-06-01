# frozen_string_literal: true

module Pry
  module Break
    class NextCommand < Pry::ClassCommand
      group "Break"
      match "next"

      description "Execute the next line within the current stack frame."

      banner <<-BANNER
        Usage: next
        Step over within the same frame. Examples:
          next #=> Move a line forward.
      BANNER

      def process
        return if check_multiline_context

        context = ::Break::Context.new(_pry_.binding_stack.last, frontend_class: Frontend)

        ::Break::Commands.execute context, :next
      end
    end

    Pry::Commands.add_command PryByebug::NextCommand
  end
end

