# frozen_string_literal: true

module Break
  class ListCommand < Command
    command :list, aliases: :ls

    def execute(*)
      frontend.where
    end
  end
end
