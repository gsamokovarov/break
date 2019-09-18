# frozen_string_literal: true

module Break
  class ListCommand < Command
    def execute(*)
      frontend.where
    end
  end
end
