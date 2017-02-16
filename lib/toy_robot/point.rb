module ToyRobot
  class Point
    attr_reader :x, :y

    def initialize(x, y)
      @x = x.to_i
      @y = y.to_i
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def +(other)
      Point.new(x + other.x, y + other.y)
    end

    def to_s
      "#{x},#{y}"
    end
  end
end
