module ToyRobot
  class Vector2D
    attr_reader :x, :y

    def self.down
      new(0, -1)
    end

    def self.left
      new(-1, 0)
    end

    def self.one
      new(1, 1)
    end

    def self.right
      new(1, 0)
    end

    def self.up
      new(0, 1)
    end

    def self.zero
      new(0, 0)
    end

    def initialize(x, y)
      @x = x.to_i
      @y = y.to_i
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def -(other)
      self.class.new(x - other.x, y - other.y)
    end

    def +(other)
      self.class.new(x + other.x, y + other.y)
    end

    def to_s
      "#{x},#{y}"
    end
  end
end
