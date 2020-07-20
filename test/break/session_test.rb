# frozen_string_literal: true

require "test_helper"

module Break
  class SessionTest < Test
    test "metadata storage" do
      session = Session.new(binding, frontend: nil)

      session[:pry_instance] = :imagine_it_exists

      assert_equal :imagine_it_exists, session[:pry_instance]
    end
  end
end
