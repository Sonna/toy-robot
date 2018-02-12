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

    def valid_move?(entity)
      (min...max).cover?(entity.next_move.x) &&
        (min...max).cover?(entity.next_move.y)
    end
  end
end
