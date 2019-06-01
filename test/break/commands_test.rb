require "test_helper"

module Break
  class CommandsTest < Test
    test "can execute commands without being mixed in a class" do
      context = Context.new(binding, frontend_class: TestingFrontend)

      Commands.execute context, :next
      frontend = TestingFrontend.last

      assert_equal [__FILE__, __LINE__ - 2], frontend.binding.source_location
    end
  end
end
