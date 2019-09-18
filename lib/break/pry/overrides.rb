# frozen_string_literal: true

module Break::Pry
  # Overrides is a module that is supposed to be prepended into ::Object's
  # ancestor chain and hook into the #pry method and prevent double break
  # sessions.
  module Overrides
    def pry(*)
      return if Break::Session.active?

      Break::Session.start!

      begin
        super
      ensure
        Break::Session.stop!
      end
    end
  end
end
