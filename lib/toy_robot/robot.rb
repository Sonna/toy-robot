require "toy_robot/compass"
require "toy_robot/transform"
require "toy_robot/vector2d"

module ToyRobot
  class Robot
    extend Forwardable
    def_delegators :@transform, :position

    attr_reader :input
    attr_reader :transform
    attr_reader :world

    ANTI_CLOCKWISE = 90.freeze # degrees
    CLOCKWISE = -90.freeze # degrees

    DIRECTIONS = {
      "NORTH" => Vector2D.up,
      "SOUTH" => Vector2D.down,
      "EAST"  => Vector2D.right,
      "WEST"  => Vector2D.left
    }.freeze

    NORTH  = Vector2D.up.freeze
    ORIGIN = Vector2D.zero.freeze

    def initialize(world, input)
      @transform = Transform.new(ORIGIN, NORTH)

      @world = world
      @input = input
      @input.control(self)
    end

    def facing
      Compass.new(transform).heading
    end

    def move(*_)
      @transform = next_move if valid_move?
    end

    def next_move
      # next_transform = transform.dup
      # next_transform.translate(DIRECTIONS[facing])
      @transform.translate(DIRECTIONS[facing])
    end

    # def position
    #   @transform.position
    # end

    def left(*_)
      @transform = transform.rotate(ANTI_CLOCKWISE)
    end

    def right(*_)
      @transform = transform.rotate(CLOCKWISE)
    end

    def place(x, y, facing_key)
      return unless DIRECTIONS.keys.include?(facing_key)
      position = Vector2D.new(x, y)
      target = position + DIRECTIONS[facing_key]
      @transform = Transform.new(position, target)
    end

    def report
      p "#{transform.position},#{facing}"
    end

    def valid_move?
      world.valid_move?(self)
    end
  end
end
