# frozen_string_literal: true

begin
  require "pry"
  require "break"

  require_relative "pry/frontend"
  require_relative "pry/commands"

  Break::Filter.register_internal MethodSource.method(:source_helper).source_location.first.chomp(".rb")
  Break::Filter.register_internal CodeRay.method(:scan).source_location.first.chomp(".rb")
  Break::Filter.register_internal Pry.method(:start).source_location.first.chomp("/pry_class.rb")
  Break::Filter.register_internal Forwardable.instance_method(:def_delegator).source_location.first.chomp(".rb")
  Break::Filter.register_internal "(pry)"
  Break::Filter.register_internal __dir__

  Pry.config.commands.import Break::Pry::Commands
rescue LoadError
  # Do nothing if we cannot require pry.
end
