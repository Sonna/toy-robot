require "toy_robot/compass"
require "toy_robot/vector2d"

module ToyRobot
  class Command
    attr_reader :entity
    # attr_reader :specified_input, :specified_output

    # def initialize(entity, specified_input, specified_output)
    def initialize(entity)
      @entity = entity
      # @specified_input = specified_input
      # @specified_output = specified_output
    end

    def match?(input)
      # does nothing
      # input == specified_input
    end

    def execute
      # does nothing
      # specified_output
      # # entity.method(specified_input).call
    end
  end

  class PlaceCommand < Command
    DIRECTIONS = {
      "NORTH" => Vector2D.up.freeze,
      "SOUTH" => Vector2D.down.freeze,
      "EAST"  => Vector2D.right.freeze,
      "WEST"  => Vector2D.left.freeze
    }.freeze

    def execute(x, y, facing)
      return unless DIRECTIONS.keys.include?(facing)
      position = Vector2D.new(x, y)
      direction = position + DIRECTIONS[facing]
      entity.transform = Transform.new(position, direction)
    end

    # def specified_input
    def match?(input)
      input == "PLACE"
    end
  end

  class MoveCommand < Command
    DIRECTIONS = {
      "NORTH" => Vector2D.up.freeze,
      "SOUTH" => Vector2D.down.freeze,
      "EAST"  => Vector2D.right.freeze,
      "WEST"  => Vector2D.left.freeze
    }.freeze

    def execute(*_)
      entity.transform.translate(DIRECTIONS[facing]) if valid_move?
    end

    def next_move
      new_transform = entity.transform.dup
      new_transform.translate(DIRECTIONS[facing])
    end

    # def specified_input
    def match?(input)
      input == "MOVE"
    end

    def valid_move?
      entity.world.valid_move?(self)
    end

    private

    def facing
      Compass.new(entity.transform).heading
    end
  end

  class LeftCommand < Command
    ANTI_CLOCKWISE = 90.freeze # degrees

    def execute(*_)
      entity.transform.rotate(ANTI_CLOCKWISE)
    end

    # def specified_input
    def match?(input)
      input == "LEFT"
    end
  end

  class RightCommand < Command
    CLOCKWISE = -90.freeze # degrees

    def execute(*_)
      entity.transform.rotate(CLOCKWISE)
    end

    # def specified_input
    def match?(input)
      input == "RIGHT"
    end
  end

  class ReportCommand < Command
    def execute
      p "#{entity.transform.position},#{facing}"
    end

    # def specified_input
    def match?(input)
      input == "REPORT"
    end

    private

    def facing
      Compass.new(entity.transform).heading
    end
  end

  class NoActionCommand < Command
    def execute
    end

    def match?(_input)
      true
    end
  end
end
