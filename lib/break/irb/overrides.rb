# frozen_string_literal: true

module Break::IRB
  module Overrides
    def irb
      session = Break::Session.new(self, frontend: Frontend.new)
      session.enter
    end
  end
end
