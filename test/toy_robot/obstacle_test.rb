require "test_helper"

module ToyRobot
  class ObstacleTest < Minitest::Test
    class BarGrid
      def add_entity(*_); end
    end

    def described_class
      Obstacle
    end

    def setup
      world = BarGrid.new
      @subject = described_class.new(world)
    end

    class DescribeMethods < ObstacleTest
      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_draw
        assert_respond_to(@subject, :draw)
      end

      def test_subject_draw
        assert_equal "O", @subject.draw
      end
    end

    class DescribedRobotInitializedAttributes < ObstacleTest
      def test_input_has_mocked_value
        world = BarGrid.new
        subject = described_class.new(world)

        assert_equal world, subject.world
      end

      def test_position_has_default_value
        assert_equal Vector2D.new(0, 0), @subject.position
      end
    end
  end
end
