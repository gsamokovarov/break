require "test_helper"

module Break
  class FilterTest < Test
    test "filters internal frames for break" do
      assert Filter.internal?("(irb)")
      assert Filter.internal?(binding.method(:break).source_location.first)
    end

    test "registers new internal frames" do
      register_internal "(pry)" do
        assert Filter.internal?("(pry)")
      end
    end

    def register_internal(*paths)
      original_internal = [].concat(Filter.internal)
      Filter.register_internal(*paths)
      yield
    ensure 
      Filter.internal.clear.concat(original_internal)
    end
  end
end
