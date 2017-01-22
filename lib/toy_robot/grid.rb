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
      entity.next_move.x >= min &&   # :east
        entity.next_move.x <= max && # :west
        entity.next_move.y >= min && # :north
        entity.next_move.y <= max    # :south
    end
  end
end
