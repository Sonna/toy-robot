require "test_helper"

module ToyRobot
  class RobotTest < Minitest::Test
    FooGrid = Struct.new(:min, :max) do
      # rubocop:disable Metrics/AbcSize
      def valid_move?(entity)
        entity.next_move.x >= min &&
          entity.next_move.y >= min &&
          entity.next_move.x <= max &&
          entity.next_move.y <= max
      end
      # rubocop:enable Metrics/AbcSize
    end

    def described_class
      Robot
    end

    def setup
      world = FooGrid.new(0, 5)
      @subject = described_class.new(world)
    end

    class DescribeMethods < RobotTest
      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_draw
        assert_respond_to(@subject, :draw)
      end

      def test_subject_draw
        assert_equal "R", @subject.draw
      end
    end

    class DescribedRobotInitializedAttributes < RobotTest
      def test_input_has_mocked_value
        world = FooGrid.new(0, 0)
        subject = described_class.new(world)

        assert_equal world, subject.world
      end

      def test_position_has_default_value
        assert_equal Vector2D.new(0, 0), @subject.position
      end
    end
  end
end
