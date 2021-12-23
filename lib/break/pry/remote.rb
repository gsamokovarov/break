begin
  require "pry-remote"

  module Break::Pry
    class << self
      attr_accessor :current_remote_server
    end

    module PryRemoteServerExtensions
      def initialize(*)
        Break::Pry.current_remote_server&.teardown

        super
      end

      def run
        return if Break::Pry.current_remote_server
        Break::Pry.current_remote_server = self

        setup

        Pry.start @object, @options.merge(input: client.input_proxy, output: client.output)
      end

      def teardown
        super
      ensure
        Break::Pry.current_remote_server = nil
      end
    end
  end

  PryRemote::Server.prepend Break::Pry::PryRemoteServerExtensions

  Break::Filter.register_internal binding.method(:remote_pry).source_location.first.chomp('.rb')
  Break::Filter.register_internal DRb.method(:start_service).source_location.first.chomp('/drb.rb')

  at_exit do
    Break::Pry.current_remote_server&.teardown
  end
rescue LoadError
  # Do nothing if we cannot require pry-remote.
end
