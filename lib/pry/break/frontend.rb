# frozen_string_literal: true

module Pry
  module Break
    class Frontend
      def initialize(binding)
        @binding = binding
      end

      def attach(context)
      end

      def detach
        throw :breakout
      end
    end
  end
end
