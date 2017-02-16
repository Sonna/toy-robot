require "test_helper"

module ToyRobot
  class CompassTest < Minitest::Test
    FooVector2D = Struct.new(:x, :y)
    FooTransform = Struct.new(:position, :target)

    def described_class
      Compass
    end

    def test_compass_heading_faces_east
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(1, 0)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "EAST", subject.heading
    end

    def test_compass_heading_faces_north_east
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(1, 1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "NORTH-EAST", subject.heading
    end

    def test_compass_heading_faces_north
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(0, 1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "NORTH", subject.heading
    end

    def test_compass_heading_faces_north_west
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(-1, 1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "NORTH-WEST", subject.heading
    end

    def test_compass_heading_faces_west
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(-1, 0)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "WEST", subject.heading
    end

    def test_compass_heading_faces_south_west
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(-1, -1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "SOUTH-WEST", subject.heading
    end

    def test_compass_heading_faces_south
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(0, -1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "SOUTH", subject.heading
    end

    def test_compass_heading_faces_south_east
      position = FooVector2D.new(0, 0)
      target = FooVector2D.new(1, -1)
      transform = FooTransform.new(position, target)
      subject = described_class.new(transform)
      assert_equal "SOUTH-EAST", subject.heading
    end
  end
end
