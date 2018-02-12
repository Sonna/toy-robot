require "test_helper"

module ToyRobot
  class GridTest < Minitest::Test
    FooPoint = Struct.new(:x, :y) do
      def ==(other)
        x == other.x && y == other.y
      end
      alias_method :eql?, :==

      def hash
        [x, y].hash
      end
    end

    def described_class
      Grid
    end

    def setup
      @subject = described_class.new
    end

    class DescribeMethods < GridTest
      def test_subject_responds_to_add_entity
        assert_respond_to(@subject, :add_entity)
      end

      def test_subject_responds_to_cells
        assert_respond_to(@subject, :cells)
      end

      def test_subject_responds_to_move
        assert_respond_to(@subject, :move)
      end

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

      def test_cells_has_default_value
        expected_cells = {
          Vector2D.new(0, 0) => Cell.new(@subject),
          Vector2D.new(0, 1) => Cell.new(@subject),
          Vector2D.new(0, 2) => Cell.new(@subject),
          Vector2D.new(0, 3) => Cell.new(@subject),
          Vector2D.new(0, 4) => Cell.new(@subject),
          Vector2D.new(1, 0) => Cell.new(@subject),
          Vector2D.new(1, 1) => Cell.new(@subject),
          Vector2D.new(1, 2) => Cell.new(@subject),
          Vector2D.new(1, 3) => Cell.new(@subject),
          Vector2D.new(1, 4) => Cell.new(@subject),
          Vector2D.new(2, 0) => Cell.new(@subject),
          Vector2D.new(2, 1) => Cell.new(@subject),
          Vector2D.new(2, 2) => Cell.new(@subject),
          Vector2D.new(2, 3) => Cell.new(@subject),
          Vector2D.new(2, 4) => Cell.new(@subject),
          Vector2D.new(3, 0) => Cell.new(@subject),
          Vector2D.new(3, 1) => Cell.new(@subject),
          Vector2D.new(3, 2) => Cell.new(@subject),
          Vector2D.new(3, 3) => Cell.new(@subject),
          Vector2D.new(3, 4) => Cell.new(@subject),
          Vector2D.new(4, 0) => Cell.new(@subject),
          Vector2D.new(4, 1) => Cell.new(@subject),
          Vector2D.new(4, 2) => Cell.new(@subject),
          Vector2D.new(4, 3) => Cell.new(@subject),
          Vector2D.new(4, 4) => Cell.new(@subject)
        }

        assert_equal expected_cells, @subject.cells
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

    class DescribeDraw < GridTest
      FooDrawableEntity = Struct.new(:draw)

      def test_subject_draw
        expected_drawn_grid = <<-STRING.gsub(/^          /, "")
          .....
          .....
          .....
          .....
          .....
        STRING

        assert_equal expected_drawn_grid, @subject.draw
      end

      def test_subject_draw_with_added_entities
        subject = described_class.new

        subject.add_entity(FooPoint.new(2, 0), FooDrawableEntity.new("A"))
        subject.add_entity(FooPoint.new(1, 3), FooDrawableEntity.new("B"))
        subject.add_entity(FooPoint.new(4, 4), FooDrawableEntity.new("C"))

        expected_drawn_grid = <<-STRING.gsub(/^          /, "")
          ....C
          .B...
          .....
          .....
          ..A..
        STRING

        assert_equal expected_drawn_grid, subject.draw
      end
    end

    class DescribeMoveMethod < GridTest
      class FooEntity
        attr_reader :position

        def initialize(position)
          @position = position
        end

        def next_move
          self.class.new(FooPoint.new(position.x, position.y + 1))
        end
      end

      def test_subject_move_entity
        subject = described_class.new

        last_position = FooPoint.new(2, 0)
        next_position = FooPoint.new(2, 1)

        foo_entity = FooEntity.new(last_position)
        subject.add_entity(last_position, foo_entity)

        subject.move(foo_entity)

        assert_nil subject.cells[last_position].entity
        assert_equal subject.cells[next_position].entity, foo_entity
      end
    end
  end
end
