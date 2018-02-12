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
    alias_method :eql?, :==

    def -(other)
      self.class.new(x - other.x, y - other.y)
    end

    def +(other)
      self.class.new(x + other.x, y + other.y)
    end

    # Largest Y value to smallest
    # Smallest X value to largest
    def <=>(other)
      return -1 if y > other.y
      return -1 if y == other.y && x < other.x
      return 0 if y == other.y && x == other.x
      return 1 if y < other.y
      return 1 if y == other.y && x > other.x
    rescue
      puts other
    end

    def hash
      # x.hash ^ y.hash # XOR # But high change of collision
      [x, y].hash
    end

    def to_s
      "#{x},#{y}"
    end
  end
end
