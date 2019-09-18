# frozen_string_literal: true

module Break
  class ContinueCommand < Command
    def execute(*)
      session.leave
    end
  end
end
