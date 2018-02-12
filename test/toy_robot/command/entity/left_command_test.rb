require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeLeftCommand < CommandTest
      def described_class
        Command::Entity::LeftCommand
      end

      def test_match_is_true_when_input_is_left
        assert @subject.match?("LEFT")
      end

      def test_match_is_false_when_input_is_not_left
        assert !@subject.match?("PLACE")
      end

      def test_execute_left_command_updates_entity_transform_target
        @subject.execute
        expected_target = Vector2D.new(-1, 0)

        assert_equal expected_target, @subject.entity.transform.target
      end
    end
  end
end
