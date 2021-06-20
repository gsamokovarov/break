# frozen_string_literal: true

require_relative "break/version"
require_relative "break/session"
require_relative "break/context"
require_relative "break/command"
require_relative "break/commands"
require_relative "break/filter"
require_relative "break/binding_ext"

require_relative "break/irb"
require_relative "break/pry"

Break::Filter.register_internal __dir__
Break::Filter.register_internal "<internal:"
