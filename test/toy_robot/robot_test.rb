require "test_helper"

module ToyRobot
  class RobotTest < Minitest::Test
    def described_class
      Robot
    end

    def setup
      @subject = described_class.new
    end

    class DescribeMethods < RobotTest
      def test_subject_responds_to_facing
        assert_respond_to(@subject, :facing)
      end

      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_move
        assert_respond_to(@subject, :move)
      end

      def test_subject_responds_to_next_move
        assert_respond_to(@subject, :next_move)
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

      def test_subject_responds_to_valid_move?
        assert_respond_to(@subject, :valid_move?)
      end

      def test_facing_has_default_value
        assert_equal "NORTH", @subject.facing
      end

      def test_position_has_default_value
        assert_equal Point.new(0,0), @subject.position
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
        expected_position = Point.new(0, 1)

        assert_equal expected_position, @subject.position
      end

      def test_move_multiple_times
        3.times.each { @subject.move }
        expected_position = Point.new(0, 3)

        assert_equal expected_position, @subject.position
      end

      def test_next_moves
        assert_equal Point.new(0, 1), @subject.next_move
      end

      def test_next_move_does_not_move_robot
        @subject.next_move
        expected_position = Point.new(0, 0)

        assert_equal expected_position, @subject.position
      end

      def test_left
        @subject.left
        assert_equal "WEST", @subject.facing
      end

      def test_left_twice_faces_south
        2.times.each { @subject.left }
        assert_equal "SOUTH", @subject.facing
      end

      def test_left_three_times_faces_east
        3.times.each { @subject.left }
        assert_equal "EAST", @subject.facing
      end

      def test_left_four_times_faces_north
        4.times.each { @subject.left }
        assert_equal "NORTH", @subject.facing
      end

      def test_right
        @subject.right
        assert_equal "EAST", @subject.facing
      end

      def test_right_twice_faces_south
        2.times.each { @subject.right }
        assert_equal "SOUTH", @subject.facing
      end

      def test_right_three_times_faces_west
        3.times.each { @subject.right }
        assert_equal "WEST", @subject.facing
      end

      def test_right_four_times_faces_north
        4.times.each { @subject.right }
        assert_equal "NORTH", @subject.facing
      end

      def test_place
        @subject.place(0, 0, "NORTH")
        expected_position = Point.new(0, 0)
        assert_equal expected_position, @subject.position
      end

      def test_place_new_position
        @subject.place(1, 1, "NORTH")
        expected_position = Point.new(1, 1)
        assert_equal expected_position, @subject.position
      end

      def test_place_invalid_position
        @subject.place(-1, -1, "NORTH")
        expected_position = Point.new(-1, -1)
        assert_equal expected_position, @subject.position
      end

      # The initial brief describes:
      # > The application should discard all commands in the sequence until a
      # > valid PLACE command has been executed.
      #
      # But does not mentioned that a PLACE command can be invalid or should
      # warn the user if it is invalid
      # def test_invalid_placed_robot_does_not_move
      #   @subject.place(-1, -1, "NORTH")
      #   @subject.move
      #   expected_position = Point.new(-1, -1)
      #   assert_equal expected_position, @subject.position
      # end

      # def test_invalid_placed_robot_does_not_move_with_invalid_facing_direction
      #   @subject.place(0, 0, "NORTH-EAST")
      #   @subject.move
      #   expected_position = Point.new(0, 0)
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

      def test_valid_move_when_valid
        assert @subject.valid_move?
      end

      def test_valid_move_when_valid_from_new_position
        @subject.place(4, 2, "EAST")
        assert @subject.valid_move?
      end

      def test_valid_move_when_invalid
        @subject.place(3, 5, "NORTH")
        assert !@subject.valid_move?
      end
    end
  end
end
