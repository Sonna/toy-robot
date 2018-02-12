require "test_helper"

class ToyRobotTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ToyRobot::VERSION
  end
end
