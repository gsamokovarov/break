require_relative "break/version"
require_relative "break/session"
require_relative "break/context"
require_relative "break/commands"
require_relative "break/filter"
require_relative "break/frontend"
require_relative "break/binding_ext"

Break::Filter.register_internal IRB.method(:start).source_location.first.chomp(".rb")
Break::Filter.register_internal "(irb)"
Break::Filter.register_internal __dir__
