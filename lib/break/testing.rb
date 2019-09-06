# frozen_string_literal: true

require "minitest"

module Break
  class TestingFrontend
    class << self
      def build(&block)
        Class.new(self, &block)
      end

      def stack
        @stack ||= []
      end

      def [](index)
        stack[index]
      end

      def last
        stack.last
      end

      def clear
        stack.clear
      end
    end

    attr_reader :session

    def initialize
      self.class.stack << self
    end

    def attach(session)
      @session = session
    end

    def detach; end

    def where; end

    def notify(_message); end
  end

  class Test < Minitest::Test
    def self.test(name, &block)
      define_method("test_#{name}", &block)
    end

    def pass
      Kernel.binding.tap do |binding|
        yield binding if block_given?
      end
    end
  end
end
