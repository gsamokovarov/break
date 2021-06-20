# frozen_string_literal: true

begin
  require "pry"

  require_relative "pry/frontend"
  require_relative "pry/commands"
  require_relative "pry/extensions"

  Break::Filter.register_internal MethodSource.method(:source_helper).source_location.first.chomp(".rb")
  Break::Filter.register_internal CodeRay.method(:scan).source_location.first.chomp(".rb")
  Break::Filter.register_internal Pry.method(:start).source_location.first.chomp("/pry_class.rb")
  Break::Filter.register_internal Forwardable.instance_method(:def_delegator).source_location.first.chomp(".rb")
  Break::Filter.register_internal "(pry)"
  Break::Filter.register_internal __dir__

  Pry.config.hooks.add_hook :before_session, :start_initial_break_session do |_, _, pry|
    pry.__break_session__ ||= Break::Session.new(pry.current_binding, frontend: Break::Pry::Frontend.new)
  end

  Pry.config.commands.import Break::Pry::Commands

  begin
    require "pry-remote"

    Break::Filter.register_internal binding.method(:remote_pry).source_location.first.chomp('.rb')
    Break::Filter.register_internal DRb.method(:start_service).source_location.first.chomp('/drb.rb')

    at_exit do
      Break::Pry.current_remote_server&.teardown
    end
  rescue LoadError
    # Do nothing if we cannot require pry-remote.
  end
rescue LoadError
  # Do nothing if we cannot require pry.
end
