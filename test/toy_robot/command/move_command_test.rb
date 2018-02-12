require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeMoveCommand < CommandTest
      def described_class
        Command::MoveCommand
      end

      def test_subject_responds_to_next_move
        assert_respond_to(@subject, :next_move)
      end

      def test_subject_responds_to_next_position
        assert_respond_to(@subject, :next_position)
      end

      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_valid_move
        assert_respond_to(@subject, :valid_move?)
      end

      def test_match_is_true_when_input_is_move
        assert @subject.match?("MOVE")
      end

      def test_match_is_false_when_input_is_not_move
        assert !@subject.match?("LEFT")
      end

      def test_next_moves
        assert_equal Vector2D.new(0, 1), @subject.next_move
      end

      def test_next_move_does_not_move_robot
        @subject.next_move
        expected_position = Vector2D.new(0, 0)

        assert_equal expected_position, @subject.entity.position
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
    end
  end
end
