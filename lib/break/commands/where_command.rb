# frozen_string_literal: true

module Break
  class WhereCommand < Command
    def execute(*)
      frontend.where
    end
  end
end
