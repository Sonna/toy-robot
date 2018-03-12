require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeRemoveObjectCommand < CommandTest
      def described_class
        Command::Entity::RemoveObjectCommand
      end

      def test_match_is_true_when_input_is_remove_object
        assert @subject.match?("REMOVE_OBJECT")
      end

      def test_match_is_false_when_input_is_not_remove_object
        assert !@subject.match?("PLACE_OBJECT")
      end

      def test_object_removed_when_executed
        world = BarGrid.new(0, 5)
        entity = BarEntity.new(world)
        obstacle_transform =
          Transform.new(Vector2D.new(0, 1), Vector2D.new(0, 0))
        Obstacle.new(world, obstacle_transform)

        obstacle_position = obstacle_transform.position
        subject = described_class.new(entity)

        assert world.entities[obstacle_position]
        subject.execute
        refute world.entities[obstacle_position]
      end
    end
  end
end
