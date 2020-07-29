# frozen_string_literal: true

module Break::Pry
  class Frontend
    def attach(session)
      previous_pry = session[:pry_instance]

      @pry = Pry.start session.context.binding, __break_session__: session,
                                                input: previous_pry.input,
                                                output: previous_pry.output
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
