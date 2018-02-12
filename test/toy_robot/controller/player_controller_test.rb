require "test_helper"


module ToyRobot
  class PlayerControllerTest < Minitest::Test
    BazGrid = Struct.new(:min, :max) do
      # rubocop:disable Metrics/AbcSize
      def valid_move?(entity)
        entity.next_move.x >= min &&
          entity.next_move.y >= min &&
          entity.next_move.x <= max &&
          entity.next_move.y <= max
      end
      # rubocop:enable Metrics/AbcSize
    end

    class BazInput
      def control(_); end
    end

    class BazEntity
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
      Controller::PlayerController
    end

    def setup
      scene = world = BazGrid.new(0, 5)
      input = BazInput.new
      entity = BazEntity.new(world)
      @subject = described_class.new(scene, input, entity)
    end

    class DescribeMethods < PlayerControllerTest
      def test_subject_responds_to_scene
        assert_respond_to(@subject, :scene)
      end

      def test_subject_responds_to_input
        assert_respond_to(@subject, :input)
      end

      def test_subject_responds_to_entity
        assert_respond_to(@subject, :entity)
      end

      def test_subject_responds_to_commands
        assert_respond_to(@subject, :commands)
      end

      def test_subject_responds_to_command_for_input
        assert_respond_to(@subject, :command_for_input)
      end

      def test_subject_responds_to_handle
        assert_respond_to(@subject, :handle)
      end

      def test_subject_responds_to_handle_input
        assert_respond_to(@subject, :handle_input)
      end

      def test_subject_responds_to_move
        assert @subject.handle("MOVE")
      end

      def test_subject_responds_to_left
        assert @subject.handle("LEFT")
      end

      def test_subject_responds_to_right
        assert @subject.handle("RIGHT")
      end

      def test_subject_responds_to_place
        assert @subject.handle("PLACE", 0, 0, "NORTH")
      end

      def test_subject_responds_to_report
        $stdout = StringIO.new
        assert @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end
    end

    class DescribeRobotCommandMethods < PlayerControllerTest
      def test_move
        @subject.handle("MOVE")
        expected_position = Vector2D.new(0, 1)

        assert_equal expected_position, @subject.entity.position
      end

      def test_move_multiple_times
        3.times.each { @subject.handle("MOVE") }
        expected_position = Vector2D.new(0, 3)

        assert_equal expected_position, @subject.entity.position
      end

      def test_left
        $stdout = StringIO.new
        @subject.handle("LEFT")
        assert_equal "0,0,WEST", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.handle("LEFT") }
        assert_equal "0,0,SOUTH", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_three_times_faces_east
        $stdout = StringIO.new
        3.times.each { @subject.handle("LEFT") }
        assert_equal "0,0,EAST", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_left_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.handle("LEFT") }
        assert_equal "0,0,NORTH", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right
        $stdout = StringIO.new
        @subject.handle("RIGHT")
        assert_equal "0,0,EAST", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_twice_faces_south
        $stdout = StringIO.new
        2.times.each { @subject.handle("RIGHT") }
        assert_equal "0,0,SOUTH", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_three_times_faces_west
        $stdout = StringIO.new
        3.times.each { @subject.handle("RIGHT") }
        assert_equal "0,0,WEST", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_right_four_times_faces_north
        $stdout = StringIO.new
        4.times.each { @subject.handle("RIGHT") }
        assert_equal "0,0,NORTH", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end

      def test_place
        @subject.handle("PLACE", 0, 0, "NORTH")
        expected_position = Vector2D.new(0, 0)
        assert_equal expected_position, @subject.entity.position
      end

      def test_place_new_position
        @subject.handle("PLACE", 1, 1, "NORTH")
        expected_position = Vector2D.new(1, 1)
        assert_equal expected_position, @subject.entity.position
      end

      def test_place_invalid_position
        @subject.handle("PLACE", -1, -1, "NORTH")
        expected_position = Vector2D.new(-1, -1)
        assert_equal expected_position, @subject.entity.position
      end

      # The initial brief describes:
      # > The application should discard all commands in the sequence until a
      # > valid PLACE command has been executed.
      #
      # But does not mentioned that a PLACE command can be invalid or should
      # warn the user if it is invalid
      def test_invalid_placed_robot_does_not_move
        @subject.handle("PLACE", -1, -1, "NORTH")
        @subject.handle("MOVE")
        expected_position = Vector2D.new(-1, -1)
        assert_equal expected_position, @subject.entity.position
      end

      def test_report_with_new_position_and_facing
        @subject.handle("PLACE", 5, 3, "SOUTH")
        $stdout = StringIO.new
        assert_equal "5,3,SOUTH", @subject.handle("REPORT")
      ensure
        $stdout = STDOUT
      end
    end
  end
end
