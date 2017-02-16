require "test_helper"

module ToyRobot
  class PointTest < Minitest::Test
    def described_class
      Point
    end

    class DescribeMethods < PointTest
      def setup
        x = y = 0
        @subject = described_class.new(x, y)
      end

      def test_subject_responds_to_x
        assert_respond_to(@subject, :x)
      end

      def test_subject_responds_to_y
        assert_respond_to(@subject, :y)
      end

      def test_subject_responds_to_plus_operator
        assert_respond_to(@subject, :+)
      end

      def test_subject_responds_to_to_s
        assert_respond_to(@subject, :to_s)
      end

      def test_x_has_value
        assert_equal 0, @subject.x
      end

      def test_y_has_value
        assert_equal 0, @subject.y
      end

      def test_to_s_returns_coordinates
        assert_equal "0,0", @subject.to_s
      end
    end

    class DescribeAddMethod < PointTest
      def test_add_two_points
        point1 = described_class.new(0, 0)
        point2 = described_class.new(1, 1)

        actual_output = point1 + point2
        expected_output = described_class.new(1, 1)

        assert_equal actual_output, expected_output
      end

      def test_add_two_points_in_positive_x_direction
        point1 = described_class.new(1, 0)
        point2 = described_class.new(1, 0)

        actual_output = point1 + point2
        expected_output = described_class.new(2, 0)

        assert_equal actual_output, expected_output
      end

      def test_add_two_points_in_positive_y_direction
        point1 = described_class.new(0, 2)
        point2 = described_class.new(0, 3)

        actual_output = point1 + point2
        expected_output = described_class.new(0, 5)

        assert_equal actual_output, expected_output
      end

      def test_add_two_points_in_negative_x_direction
        point1 = described_class.new(100, 0)
        point2 = described_class.new(-50, 0)

        actual_output = point1 + point2
        expected_output = described_class.new(50, 0)

        assert_equal actual_output, expected_output
      end

      def test_add_two_points_in_negative_y_direction
        point1 = described_class.new(0, 0)
        point2 = described_class.new(0, -3)

        actual_output = point1 + point2
        expected_output = described_class.new(0, -3)

        assert_equal actual_output, expected_output
      end

      def test_add_multiple_points
        point1 = described_class.new(1, 0)
        point2 = described_class.new(0, 1)
        point3 = described_class.new(1, 1)

        actual_output = point1 + point2 + point3
        expected_output = described_class.new(2, 2)

        assert_equal actual_output, expected_output
      end
    end
  end
end
