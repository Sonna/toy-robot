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
      (min...max) === entity.next_move.x && (min...max) === entity.next_move.y
    end
  end
end
