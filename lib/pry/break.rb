# frozen_string_literal: true

require "pry"
require "break"

require_relative "break/frontend"
require_relative "break/commands"

Break::Filter.register_internal MethodSource.method(:source_helper).source_location.first.chomp(".rb")
Break::Filter.register_internal CodeRay.method(:scan).source_location.first.chomp(".rb")
Break::Filter.register_internal Pry.method(:start).source_location.first.chomp("/pry_class.rb")
Break::Filter.register_internal "(pry)"
Break::Filter.register_internal __dir__

Pvry.config.commands.import Pry::Break::Commands
