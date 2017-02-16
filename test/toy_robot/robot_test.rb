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
      def control(_); end
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

      def test_subject_responds_to_commands
        assert_respond_to(@subject, :commands)
      end

      def test_subject_responds_to_command_for_input
        assert_respond_to(@subject, :command_for_input)
      end

      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_process
        assert_respond_to(@subject, :process)
      end

      def test_subject_responds_to_move
        assert @subject.process("MOVE")
      end

      def test_subject_responds_to_left
        assert @subject.process("LEFT")
      end

      def test_subject_responds_to_right
        assert @subject.process("RIGHT")
      end

      def test_subject_responds_to_place
        assert @subject.process("PLACE", 0, 0, "NORTH")
      end

      def test_subject_responds_to_report
        $stdout = StringIO.new
        assert @subject.process("REPORT")
      ensure
        $stdout = STDOUT
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
        assert_equal "0,0,NORTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end
    end

    class DescribeRobotCommandMethods < RobotTest
      def test_move
        @subject.process("MOVE")
        expected_position = Vector2D.new(0, 1)

        assert_equal expected_position, @subject.position
      end

      def test_move_multiple_times
        3.times.each { @subject.process("MOVE") }
        expected_position = Vector2D.new(0, 3)

        assert_equal expected_position, @subject.position
      end

      def test_left
        $stdout = StringIO.new
        @subject.process("LEFT")
        assert_equal "0,0,WEST", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.process("LEFT") }
        assert_equal "0,0,SOUTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_three_times_faces_east
        $stdout = StringIO.new
        3.times.each { @subject.process("LEFT") }
        assert_equal "0,0,EAST", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.process("LEFT") }
        assert_equal "0,0,NORTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right
        $stdout = StringIO.new
        @subject.process("RIGHT")
        assert_equal "0,0,EAST", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.process("RIGHT") }
        assert_equal "0,0,SOUTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_three_times_faces_west
        $stdout = StringIO.new
        3.times.each { @subject.process("RIGHT") }
        assert_equal "0,0,WEST", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.process("RIGHT") }
        assert_equal "0,0,NORTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_place
        @subject.process("PLACE", 0, 0, "NORTH")
        expected_position = Vector2D.new(0, 0)
        assert_equal expected_position, @subject.position
      end

      def test_place_new_position
        @subject.process("PLACE", 1, 1, "NORTH")
        expected_position = Vector2D.new(1, 1)
        assert_equal expected_position, @subject.position
      end

      def test_place_invalid_position
        @subject.process("PLACE", -1, -1, "NORTH")
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
        @subject.process("PLACE", -1, -1, "NORTH")
        @subject.process("MOVE")
        expected_position = Vector2D.new(-1, -1)
        assert_equal expected_position, @subject.position
      end

      def test_report_with_new_position_and_facing
        @subject.process("PLACE", 5, 3, "SOUTH")
        $stdout = StringIO.new
        assert_equal "5,3,SOUTH", @subject.process("REPORT")
      ensure
        $stdout = STDOUT
      end
    end
  end
end
