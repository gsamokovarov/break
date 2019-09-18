# frozen_string_literal: true

module Break::IRB
  module Overrides
    def irb
      return if Break::Session.active?

      Break::Session.start!

      begin
        session = Break::Session.new(self, frontend: Frontend.new)
        session.enter
      ensure
        Break::Session.stop!
      end
    end
  end
end
