require "test_helper"

module Break
  class CommandsTest < Test
    test "can execute commands without being mixed in a class" do
      session = Session.new(binding, frontend: TestingFrontend.new)

      Commands.execute session, :next
      frontend = TestingFrontend.last

      assert_equal [__FILE__, __LINE__ - 2], session.context.binding.source_location
    end
  end
end
