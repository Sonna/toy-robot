require "toy_robot/point"

module ToyRobot
  class Robot
    attr_reader :facing
    attr_reader :input
    attr_reader :position
    attr_reader :world

    DIRECTIONS = {
      "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right:  "EAST" },
      "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right:  "WEST" },
      "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH" },
      "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH" }
    }.freeze

    def initialize(world, input)
      @facing = "NORTH"
      @position = Point.new(0, 0)

      @world = world
      @input = input
      @input.control(self)
    end

    def move(*_)
      @position = next_move if valid_move?
    end

    def next_move
      @position + DIRECTIONS[facing][:move]
    end

    def left(*_)
      @facing = DIRECTIONS[facing][:left]
    end

    def right(*_)
      @facing = DIRECTIONS[facing][:right]
    end

    def place(x, y, facing)
      return unless DIRECTIONS.keys.include?(facing)
      @position = Point.new(x, y)
      @facing = facing
    end

    def report
      p "#{position},#{facing}"
    end

    def valid_move?
      world.valid_move?(self)
    end
  end
end
