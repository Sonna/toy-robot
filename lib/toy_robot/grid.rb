require "toy_robot/cell"

module ToyRobot
  class Grid
    MAX = 5
    MIN = 0

    attr_reader :max, :min

    def initialize(min = MIN, max = MAX)
      @min = min
      @max = max
    end

    def valid_move?(entity)
      (min...max).cover?(entity.next_move.x) &&
        (min...max).cover?(entity.next_move.y)
    end
  end
end
