require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribePlaceCommand < CommandTest
      def described_class
        Command::Entity::PlaceCommand
      end

      def test_match_is_true_when_input_is_place
        assert @subject.match?("PLACE")
      end

      def test_match_is_false_when_input_is_not_place
        assert !@subject.match?("REPORT")
      end

      def test_execute_place_command_updates_entity_transform
        @subject.execute(3, 4, "NORTH")
        expected_transform = Transform.new(
          Vector2D.new(3, 4),
          Vector2D.new(3, 4) + Vector2D.up
        )

        assert_equal expected_transform, @subject.entity.transform
      end
    end
  end
end
