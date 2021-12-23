# frozen_string_literal: true

module Break::Pry
  module PryExtensions
    attr_accessor :__break_session__

    def initialize(options = {})
      super(options)

      @__break_session__ = options[:__break_session__]
    end
  end
end

Pry.prepend Break::Pry::PryExtensions
