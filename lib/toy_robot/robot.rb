require "toy_robot/compass"
require "toy_robot/vector2d"

module ToyRobot
  class Robot
    # attr_reader :facing
    attr_reader :input
    attr_reader :position
    attr_reader :world

    DIRECTIONS = {
      "NORTH" => { move: Vector2D.up,    left:  "WEST", right:  "EAST" },
      "SOUTH" => { move: Vector2D.down,  left:  "EAST", right:  "WEST" },
      "EAST"  => { move: Vector2D.right, left: "NORTH", right: "SOUTH" },
      "WEST"  => { move: Vector2D.left,  left: "SOUTH", right: "NORTH" }
    }.freeze

    NORTH  = Vector2D.up.freeze
    ORIGIN = Vector2D.zero.freeze

    TempTransform = Struct.new(:position, :target)

    def initialize(world, input)
      @facing = "NORTH" # NORTH
      @position = ORIGIN

      @world = world
      @input = input
      @input.control(self)
    end

    def facing
      transform = TempTransform.new(position, next_move)
      Compass.new(transform).heading
    end

    def move(*_)
      @position = next_move if valid_move?
    end

    def next_move
      @position + DIRECTIONS[@facing][:move]
    end

    def left(*_)
      @facing = DIRECTIONS[facing][:left]
    end

    def right(*_)
      @facing = DIRECTIONS[facing][:right]
    end

    def place(x, y, facing)
      return unless DIRECTIONS.keys.include?(facing)
      @position = Vector2D.new(x, y)
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
