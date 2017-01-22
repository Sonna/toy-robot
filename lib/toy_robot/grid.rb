module ToyRobot
  class Grid
    MAX = 5
    MIN = 0

    attr_reader :max, :min

    def initialize(min = MIN, max = MAX)
      @min = min
      @max = max
    end
  end
end
