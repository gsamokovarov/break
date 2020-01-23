# frozen_string_literal: true

require "pathname"

module Break::IRB
  class Commands < Module
    def initialize(session)
      define_command session, :next,     Break::NextCommand
      define_command session, :step,     Break::StepCommand
      define_command session, :up,       Break::UpCommand
      define_command session, :down,     Break::DownCommand
      define_command session, :whereami, Break::WhereCommand
    end

    private

    def define_command(session, name, cls)
      define_method(name) do |*args|
        cls.new(session).execute(*args)
      end
    end
  end
end
