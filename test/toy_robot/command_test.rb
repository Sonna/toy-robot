require "test_helper"

module ToyRobot
  class CommandTest < Minitest::Test
    BarGrid = Struct.new(:min, :max) do
      def valid_move?(entity)
        (min...max) === entity.next_move.x && (min...max) === entity.next_move.y
      end
    end

    class BarEntity
      extend Forwardable
      def_delegators :@transform, :position

      attr_accessor :transform

      attr_reader :world

      def initialize(world)
        @transform = Transform.new(Vector2D.zero, Vector2D.up)
        @world = world
      end
    end

    def described_class
      Command
    end

    def setup
      world = BarGrid.new(0, 5)
      entity = BarEntity.new(world)
      @subject = described_class.new(entity)
    end

    def test_subject_responds_to_execute
      assert_respond_to(@subject, :execute)
    end

    def test_subject_responds_to_match
      assert_respond_to(@subject, :match?)
    end

    class DescribePlaceCommand < CommandTest
      def described_class
        PlaceCommand
      end

      def test_match_is_true_when_input_is_PLACE
        assert @subject.match?("PLACE")
      end

      def test_match_is_false_when_input_is_not_PLACE
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

    class DescribeMoveCommand < CommandTest
      def described_class
        MoveCommand
      end

      def test_match_is_true_when_input_is_MOVE
        assert @subject.match?("MOVE")
      end

      def test_match_is_false_when_input_is_not_MOVE
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

    class DescribeLeftCommand < CommandTest
      def described_class
        LeftCommand
      end

      def test_match_is_true_when_input_is_LEFT
        assert @subject.match?("LEFT")
      end

      def test_match_is_false_when_input_is_not_LEFT
        assert !@subject.match?("PLACE")
      end

      def test_execute_left_command_updates_entity_transform_target
        @subject.execute
        expected_target = Vector2D.new(-1, 0)

        assert_equal expected_target, @subject.entity.transform.target
      end
    end

    class DescribeRightCommand < CommandTest
      def described_class
        RightCommand
      end

      def test_match_is_true_when_input_is_RIGHT
        assert @subject.match?("RIGHT")
      end

      def test_match_is_false_when_input_is_not_RIGHT
        assert !@subject.match?("PLACE")
      end

      def test_execute_right_command_updates_entity_transform_target
        @subject.execute
        expected_target = Vector2D.new(1, 0)

        assert_equal expected_target, @subject.entity.transform.target
      end
    end

    class DescribeReportCommand < CommandTest
      def described_class
        ReportCommand
      end

      def test_match_is_true_when_input_is_REPORT
        assert @subject.match?("REPORT")
      end

      def test_match_is_false_when_input_is_not_REPORT
        assert !@subject.match?("PLACE")
      end

      def test_facing_has_default_value
        assert_equal "NORTH", @subject.send(:facing)
      end

      def test_execute_report_command
        $stdout = StringIO.new
        assert_equal "0,0,NORTH", @subject.execute
      ensure
        $stdout = STDOUT
      end
    end

    class DescribeNoActionCommand < CommandTest
      def described_class
        NoActionCommand
      end

      def test_match_is_true_when_input_is_anything
        assert @subject.match?("REPORT")
      end

      def test_match_is_false_when_input_is_nothing
        assert @subject.match?(" ")
      end

      def test_execute_no_action_does_nothing
        assert !@subject.execute
      end
    end
  end
end
