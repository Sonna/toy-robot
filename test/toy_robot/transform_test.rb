require "test_helper"

module ToyRobot
  class TransformTest < Minitest::Test
    # BarVector2D = Struct.new(:x, :y)

    def described_class
      Transform
    end

    def setup
      position = Vector2D.new(0, 0) # origin
      target = Vector2D.new(0, 2)   # north
      @subject = described_class.new(position, target)
    end

    class DescribeInterface < TransformTest
      def test_subject_responds_to_position
        assert_respond_to(@subject, :position)
      end

      def test_subject_responds_to_target
        assert_respond_to(@subject, :target)
      end

      def test_subject_responds_to_plus_operator
        assert_respond_to(@subject, :+)
      end

      def test_subject_responds_to_translate
        assert_respond_to(@subject, :translate)
      end

      def test_subject_responds_to_rotate
        assert_respond_to(@subject, :rotate)
      end
    end

    class DescribedInitializedAttributes < TransformTest
      def test_position_has_default_value
        assert_equal Vector2D.new(0, 0), @subject.position
      end

      def test_target_has_default_value
        assert_equal Vector2D.new(0, 2), @subject.target
      end
    end

    class DescribeMethods < TransformTest
      def test_plus_operator
        transform1 = described_class.new(Vector2D.new(0, 1), Vector2D.new(0, 2))
        transform2 = described_class.new(Vector2D.new(1, 0), Vector2D.new(0, 1))

        new_transform = transform1 + transform2

        expected_position = Vector2D.new(1, 1)
        expected_target = Vector2D.new(0, 3)

        assert_equal expected_position, new_transform.position
        assert_equal expected_target, new_transform.target
      end

      def test_translate
        translation = Vector2D.new(0, 5)
        new_transform = @subject.translate(translation)

        assert_equal Vector2D.new(0, 5), new_transform.position
        assert_equal Vector2D.new(0, 7), new_transform.target
      end

      # Vector.new(origin, north).rotate(  90)
      # # => <Vector v1=(0,0), v2=(-2,0) facing="WEST">
      def test_rotate_90_degrees
        angle = 90
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(-2, 0), new_transform.target
      end

      # Vector.new(origin, north).rotate( 180)
      # # => <Vector v1=(0,0), v2=(0,-2) facing="SOUTH">
      def test_rotate_180_degrees
        angle = 180
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(0, -2), new_transform.target
      end

      # Vector.new(origin, north).rotate( 270)
      # # => <Vector v1=(0,0), v2=(2,0) facing="EAST">
      def test_rotate_270_degrees
        angle = 270
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(2, 0), new_transform.target
      end

      # Vector.new(origin, north).rotate( 360)
      # # => <Vector v1=(0,0), v2=(0,2) facing="NORTH">
      def test_rotate_360_degrees
        angle = 360
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(0, 2), new_transform.target
      end

      # Vector.new(origin, north).rotate( -90)
      # # => <Vector v1=(0,0), v2=(2,0) facing="EAST">
      def test_rotate_negative_90_degrees
        angle = -90
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(2, 0), new_transform.target
      end

      # Vector.new(origin, north).rotate(-180)
      # # => <Vector v1=(0,0), v2=(0,-2) facing="SOUTH">
      def test_rotate_negative_180_degrees
        angle = -180
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(0, -2), new_transform.target
      end

      # Vector.new(origin, north).rotate(-270)
      # # => <Vector v1=(0,0), v2=(-2,0) facing="WEST">
      def test_rotate_negative_270_degrees
        angle = -270
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(-2, 0), new_transform.target
      end

      # Vector.new(origin, north).rotate(-360)
      # # => <Vector v1=(0,0), v2=(0,2) facing="NORTH">
      def test_rotate_negative_360_degrees
        angle = -360
        new_transform = @subject.rotate(angle)

        assert_equal Vector2D.new(0, 0), new_transform.position
        assert_equal Vector2D.new(0, 2), new_transform.target
      end
    end
  end
end
