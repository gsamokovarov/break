# frozen_string_literal: true

require "pry"
require "break"

require_relative "pry/frontend"
require_relative "pry/commands"
require_relative "pry/overrides"

Break::Filter.register_internal MethodSource.method(:source_helper).source_location.first.chomp(".rb")
Break::Filter.register_internal CodeRay.method(:scan).source_location.first.chomp(".rb")
Break::Filter.register_internal Pry.method(:start).source_location.first.chomp("/pry_class.rb")
Break::Filter.register_internal "(pry)"
Break::Filter.register_internal __dir__

Object.prepend Break::Pry::Overrides

Pry.config.commands.import Break::Pry::Commands
Pry.config.commands.alias_command "list", "whereami"
