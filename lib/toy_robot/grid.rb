require "toy_robot/cell"
require "toy_robot/vector2d"

module ToyRobot
  class Grid
    MAX = 5
    MIN = 0

    attr_reader :cells
    attr_reader :max
    attr_reader :min

    def initialize(min = MIN, max = MAX)
      @min = min
      @max = max

      min2max = (min...max).to_a
      @cells = min2max.product(min2max).each_with_object({}) do |(x, y), cells|
        cells[Vector2D.new(x, y)] = Cell.new(self)
      end
    end

    def add_entity(vector2d, entity)
      @cells[vector2d].entity = entity
    end

    def valid_move?(entity)
      (min...max).cover?(entity.next_move.x) &&
        (min...max).cover?(entity.next_move.y)
    end

    def draw
      cells.sort.each_with_object([]) do |(vector2d, cell), canvas|
        canvas << cell.draw
        canvas << "\n" if vector2d.x == (max - 1)
      end.join
    end
  end
end
