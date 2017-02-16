require "test_helper"

module ToyRobot
  class RobotTest < Minitest::Test
    FooGrid = Struct.new(:min, :max) do
      def valid_move?(entity)
        entity.next_move.x >= min &&
          entity.next_move.y >= min &&
          entity.next_move.x <= max &&
          entity.next_move.y <= max
      end
    end

    class FooInput
      def control(_)
      end
    end

    def described_class
      Robot
    end

    def setup
      input = FooInput.new
      world = FooGrid.new(0, 5)
      @subject = described_class.new(world, input)
    end

    class DescribeMethods < RobotTest
      def test_subject_responds_to_input
        assert_respond_to(@subject, :input)
      end

      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_move
        assert_respond_to(@subject, :move)
      end

      def test_subject_responds_to_left
        assert_respond_to(@subject, :left)
      end

      def test_subject_responds_to_right
        assert_respond_to(@subject, :right)
      end

      def test_subject_responds_to_place
        assert_respond_to(@subject, :place)
      end

      def test_subject_responds_to_report
        assert_respond_to(@subject, :report)
      end
    end

    class DescribedRobotInitializedAttributes < RobotTest
      def test_input_has_mocked_value
        input = FooInput.new
        world = FooGrid.new(0, 0)
        subject = described_class.new(world, input)

        assert_equal input, subject.input
      end

      def test_position_has_default_value
        assert_equal Vector2D.new(0, 0), @subject.position
      end

      def test_report_default_value
        $stdout = StringIO.new
        assert_equal "0,0,NORTH", @subject.report
      ensure
        $stdout = STDOUT
      end
    end

    class DescribeRobotCommandMethods < RobotTest
      def test_move
        @subject.move
        expected_position = Vector2D.new(0, 1)

        assert_equal expected_position, @subject.position
      end

      def test_move_multiple_times
        3.times.each { @subject.move }
        expected_position = Vector2D.new(0, 3)

        assert_equal expected_position, @subject.position
      end

      def test_left
        $stdout = StringIO.new
        @subject.left
        assert_equal "0,0,WEST", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_left_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.left }
        assert_equal "0,0,SOUTH", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_left_three_times_faces_east
        $stdout = StringIO.new
        3.times.each { @subject.left }
        assert_equal "0,0,EAST", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_left_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.left }
        assert_equal "0,0,NORTH", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_right
        $stdout = StringIO.new
        @subject.right
        assert_equal "0,0,EAST", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_right_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.right }
        assert_equal "0,0,SOUTH", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_right_three_times_faces_west
        $stdout = StringIO.new
        3.times.each { @subject.right }
        assert_equal "0,0,WEST", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_right_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.right }
        assert_equal "0,0,NORTH", @subject.report
      ensure
        $stdout = STDOUT
      end

      def test_place
        @subject.place(0, 0, "NORTH")
        expected_position = Vector2D.new(0, 0)
        assert_equal expected_position, @subject.position
      end

      def test_place_new_position
        @subject.place(1, 1, "NORTH")
        expected_position = Vector2D.new(1, 1)
        assert_equal expected_position, @subject.position
      end

      def test_place_invalid_position
        @subject.place(-1, -1, "NORTH")
        expected_position = Vector2D.new(-1, -1)
        assert_equal expected_position, @subject.position
      end

      # The initial brief describes:
      # > The application should discard all commands in the sequence until a
      # > valid PLACE command has been executed.
      #
      # But does not mentioned that a PLACE command can be invalid or should
      # warn the user if it is invalid
      def test_invalid_placed_robot_does_not_move
        @subject.place(-1, -1, "NORTH")
        @subject.move
        expected_position = Vector2D.new(-1, -1)
        assert_equal expected_position, @subject.position
      end

      # def test_invalid_placed_robot_does_not_move_with_invalid_facing_direction
      #   @subject.place(0, 0, "NORTH-EAST")
      #   @subject.move
      #   expected_position = Vector2D.new(0, 0)
      #   assert_equal expected_position, @subject.position
      # end

      # def test_invalid_placed_robot_does_not_turn_left
      #   @subject.place(-1, -1, "NORTH")
      #   @subject.left
      #   assert_equal "NORTH", @subject.facing
      # end

      # def test_invalid_placed_robot_does_not_turn_right
      #   @subject.place(-1, -1, "NORTH")
      #   @subject.right
      #   assert_equal "NORTH", @subject.facing
      # end

      def test_report_with_new_position_and_facing
        @subject.place(5, 3, "SOUTH")
        $stdout = StringIO.new
        assert_equal "5,3,SOUTH", @subject.report
      ensure
        $stdout = STDOUT
      end
    end
  end
end
