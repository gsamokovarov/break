# frozen_string_literal: true

module Break
  class ContinueCommand < Command
    command :continue, aliases: :c

    def execute(*)
      session.leave
    end
  end
end
