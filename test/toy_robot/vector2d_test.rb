require "test_helper"

module ToyRobot
  class Vector2DTest < Minitest::Test
    def described_class
      Vector2D
    end

    class DescribeClassMethods < Vector2DTest
      def test_described_class_responds_to_down
        assert_respond_to(described_class, :down)
      end

      def test_described_class_responds_to_left
        assert_respond_to(described_class, :left)
      end

      def test_described_class_responds_to_one
        assert_respond_to(described_class, :one)
      end

      def test_described_class_responds_to_right
        assert_respond_to(described_class, :right)
      end

      def test_described_class_responds_to_up
        assert_respond_to(described_class, :up)
      end

      def test_described_class_responds_to_zero
        assert_respond_to(described_class, :zero)
      end

      def test_described_class_returns_down
        assert_equal(described_class.down, Vector2D.new(0, -1))
      end

      def test_described_class_returns_left
        assert_equal(described_class.left, Vector2D.new(-1, 0))
      end

      def test_described_class_returns_one
        assert_equal(described_class.one, Vector2D.new(1, 1))
      end

      def test_described_class_returns_right
        assert_equal(described_class.right, Vector2D.new(1, 0))
      end

      def test_described_class_returns_up
        assert_equal(described_class.up, Vector2D.new(0, 1))
      end

      def test_described_class_returns_zero
        assert_equal(described_class.zero, Vector2D.new(0, 0))
      end
    end

    class DescribeInstanceMethods < Vector2DTest
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

      def test_subject_responds_to_minus_operator
        assert_respond_to(@subject, :-)
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

    class DescribeAddMethod < Vector2DTest
      def test_add_two_vectors
        point1 = described_class.new(0, 0)
        point2 = described_class.new(1, 1)

        actual_output = point1 + point2
        expected_output = described_class.new(1, 1)

        assert_equal actual_output, expected_output
      end

      def test_add_two_vectors_in_positive_x_direction
        point1 = described_class.new(1, 0)
        point2 = described_class.new(1, 0)

        actual_output = point1 + point2
        expected_output = described_class.new(2, 0)

        assert_equal actual_output, expected_output
      end

      def test_add_two_vectors_in_positive_y_direction
        point1 = described_class.new(0, 2)
        point2 = described_class.new(0, 3)

        actual_output = point1 + point2
        expected_output = described_class.new(0, 5)

        assert_equal actual_output, expected_output
      end

      def test_add_two_vectors_in_negative_x_direction
        point1 = described_class.new(100, 0)
        point2 = described_class.new(-50, 0)

        actual_output = point1 + point2
        expected_output = described_class.new(50, 0)

        assert_equal actual_output, expected_output
      end

      def test_add_two_vectors_in_negative_y_direction
        point1 = described_class.new(0, 0)
        point2 = described_class.new(0, -3)

        actual_output = point1 + point2
        expected_output = described_class.new(0, -3)

        assert_equal actual_output, expected_output
      end

      def test_add_multiple_vectors
        point1 = described_class.new(1, 0)
        point2 = described_class.new(0, 1)
        point3 = described_class.new(1, 1)

        actual_output = point1 + point2 + point3
        expected_output = described_class.new(2, 2)

        assert_equal actual_output, expected_output
      end
    end

    class DescribeMinusMethod < Vector2DTest
      def test_minus_two_vectors
        point1 = described_class.new(0, 0)
        point2 = described_class.new(1, 1)

        actual_output = point1 - point2
        expected_output = described_class.new(-1, -1)

        assert_equal actual_output, expected_output
      end

      def test_minus_two_vectors_in_positive_x_direction
        point1 = described_class.new(1, 0)
        point2 = described_class.new(1, 0)

        actual_output = point1 - point2
        expected_output = described_class.new(0, 0)

        assert_equal actual_output, expected_output
      end

      def test_minus_two_vectors_in_positive_y_direction
        point1 = described_class.new(0, 2)
        point2 = described_class.new(0, 3)

        actual_output = point1 - point2
        expected_output = described_class.new(0, -1)

        assert_equal actual_output, expected_output
      end

      def test_minus_two_vectors_in_negative_x_direction
        point1 = described_class.new(100, 0)
        point2 = described_class.new(-50, 0)

        actual_output = point1 - point2
        expected_output = described_class.new(150, 0)

        assert_equal actual_output, expected_output
      end

      def test_minus_two_vectors_in_negative_y_direction
        point1 = described_class.new(0, 0)
        point2 = described_class.new(0, -3)

        actual_output = point1 - point2
        expected_output = described_class.new(0, 3)

        assert_equal actual_output, expected_output
      end

      def test_minus_multiple_vectors
        point1 = described_class.new(1, 0)
        point2 = described_class.new(0, 1)
        point3 = described_class.new(1, 1)

        actual_output = point1 - point2 - point3
        expected_output = described_class.new(0, -2)

        assert_equal actual_output, expected_output
      end
    end
  end
end
