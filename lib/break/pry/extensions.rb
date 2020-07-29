# frozen_string_literal: true

module Break::Pry
  module PryExtensions
    attr_accessor :__break_session__

    def initialize(options)
      super(options)

      @__break_session__ = options[:__break_session__]
    end
  end
end

Pry.prepend Break::Pry::PryExtensions

begin
  require "pry-remote"

  module Break::Pry
    class << self
      attr_accessor :current_remote_server
    end

    module PryRemoteServerExtensions
      def initialize(*args)
        super(*args)
      rescue Errno::EADDRINUSE
      end

      def run
        return if Break::Pry.current_remote_server
        Break::Pry.current_remote_server = self

        setup

        Pry.start @object, @options.merge(input: client.input_proxy, output: client.output)
      end

      def teardown
        return if @teardowned

        super

        Break::Pry.current_remote_server = nil
        @teardowned = true
      end
    end
  end

  PryRemote::Server.prepend Break::Pry::PryRemoteServerExtensions
rescue LoadError
  # Do nothing if we cannot require pry-remote.
end
