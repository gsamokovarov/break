# frozen_string_literal: true

module Pry::Break
  class Frontend
    def initialize(pry)
      @pry = pry
    end

    def attach(session)
      @pry = Pry.start(session.context.binding)
      where
    end

    def detach
      throw :breakout
    end

    def where
      @pry&.run_command "whereami".dup
    rescue MethodSource::SourceNotFoundError
      puts "Cannot find method code."
    end

    def notify(message)
      puts message
    end
  end
end
