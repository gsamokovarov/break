require "test_helper"

module Break
  class FilterTest < Test
    test "filters internal frames for break" do
      assert Filter.internal?("(irb)")
      assert Filter.internal?(binding.method(:break).source_location.first)
    end
  end
end

