require "test_helper"

module ToyRobot
  class GridTest < Minitest::Test
    def described_class
      Grid
    end

    def setup
      @subject = described_class.new
    end

    class DescribeMethods < GridTest
      def test_subject_responds_to_min
        assert_respond_to(@subject, :min)
      end

      def test_subject_responds_to_max
        assert_respond_to(@subject, :max)
      end
    end

    class DescribedGridInitializedAttributes < GridTest
      def test_min_has_default_value
        assert_equal 0, @subject.min
      end

      def test_max_has_default_value
        assert_equal 5, @subject.max
      end

      def test_set_min_value_on_initialize
        subject = described_class.new(1)
        assert_equal 1, subject.min
      end

      def test_set_max_value_on_initialize
        subject = described_class.new(0, 6)
        assert_equal 6, subject.max
      end
    end

    class DescribeValidMove < GridTest
      BarEntity = Struct.new(:next_move)
      FooPoint = Struct.new(:x, :y)

      def test_valid_move_inside_default_min_max
        entity = BarEntity.new(FooPoint.new(1, 2))
        assert @subject.valid_move?(entity)
      end

      def test_valid_move_inside_new_min_max
        subject = described_class.new(1, 4)
        entity = BarEntity.new(FooPoint.new(2, 3))
        assert subject.valid_move?(entity)
      end

      def test_valid_move_inside_new_negative_min_max
        subject = described_class.new(-6, -2)
        entity = BarEntity.new(FooPoint.new(-3, -4))
        assert subject.valid_move?(entity)
      end

      def test_valid_move_is_false_outside_default_max
        entity = BarEntity.new(FooPoint.new(6, 6))
        assert !@subject.valid_move?(entity)
      end

      def test_valid_move_is_false_outside_default_min
        entity = BarEntity.new(FooPoint.new(-1, 0))
        assert !@subject.valid_move?(entity)
      end

      def test_valid_move_is_false_outside_new_min
        subject = described_class.new(-2, 2)
        entity = BarEntity.new(FooPoint.new(-4, 1))
        assert !subject.valid_move?(entity)
      end

      def test_valid_move_is_valid_inside_default_max_x
        subject = described_class.new(0, 5)
        entity = BarEntity.new(FooPoint.new(4, 2))
        assert subject.valid_move?(entity)
      end

      def test_valid_move_is_invalid_outside_default_max_x
        subject = described_class.new(0, 5)
        entity = BarEntity.new(FooPoint.new(5, 2))
        assert !subject.valid_move?(entity)
      end

      def test_valid_move_is_valid_inside_default_max_y
        subject = described_class.new(0, 5)
        entity = BarEntity.new(FooPoint.new(2, 4))
        assert subject.valid_move?(entity)
      end

      def test_valid_move_is_invalid_outside_default_max_y
        subject = described_class.new(0, 5)
        entity = BarEntity.new(FooPoint.new(2, 5))
        assert !subject.valid_move?(entity)
      end
    end
  end
end
