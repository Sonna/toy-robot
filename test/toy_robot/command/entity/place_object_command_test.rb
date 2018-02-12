require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribePlaceObjectCommand < CommandTest
      def described_class
        Command::Entity::PlaceObjectCommand
      end

      def obstacle_class
        Obstacle
      end

      def test_subject_responds_to_next_move
        assert_respond_to(@subject, :next_move)
      end

      def test_subject_responds_to_next_position
        assert_respond_to(@subject, :next_position)
      end

      def test_subject_responds_to_valid_move
        assert_respond_to(@subject, :valid_move?)
      end

      def test_match_is_true_when_input_is_place_object
        assert @subject.match?("PLACE_OBJECT")
      end

      def test_match_is_false_when_input_is_not_place_object
        assert !@subject.match?("MOVE")
      end

      def test_next_move
        assert_equal Vector2D.new(0, 1), @subject.next_move
      end

      def test_valid_move_when_valid
        assert @subject.valid_move?
      end

      def test_valid_move_when_invalid
        # @subject.place(3, 4, "NORTH")
        @subject.entity.transform = Transform.new(
          Vector2D.new(3, 4),
          Vector2D.new(3, 4) + Vector2D.up
        )
        assert !@subject.valid_move?
      end

      def test_valid_move_when_valid_from_new_position
        # @subject.place(3, 2, "EAST")
        @subject.entity.transform = Transform.new(
          Vector2D.new(3, 2),
          Vector2D.new(3, 2) + Vector2D.right
        )
        assert @subject.valid_move?
      end

      def test_object_placed_when_executed
        world = BarGrid.new(0, 5)
        entity = BarEntity.new(world)
        subject = described_class.new(entity)

        subject.execute

        obstacle_position = entity.transform.target
        expected_obstacle =
          obstacle_class.new(world, Transform.new(obstacle_position))

        assert_equal expected_obstacle, world.entities[obstacle_position]
      end
    end
  end
end
