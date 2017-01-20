require "toy_robot/point"

module ToyRobot
  class Robot
    attr_reader :facing
    attr_reader :position

    DIRECTIONS = {
      "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right: "EAST",  valid_move?: ->(context) { context.next_move.y <= 5 } },
      "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right: "WEST",  valid_move?: ->(context) { context.next_move.y >= 0 } },
      "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH", valid_move?: ->(context) { context.next_move.x <= 5 } },
      "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH", valid_move?: ->(context) { context.next_move.x >= 0 } }
    }.freeze

    def initialize
      @facing = "NORTH"
      @position = Point.new(0, 0)
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
      DIRECTIONS[facing][:valid_move?].call(self)
    end
  end
end
