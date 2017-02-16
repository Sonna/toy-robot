require "toy_robot/compass"
require "toy_robot/vector2d"

module ToyRobot
  class Command
    attr_reader :entity

    def initialize(entity)
      @entity = entity
    end

    def match?(input)
      # does nothing
    end

    def execute(*_)
      # does nothing
    end
  end

  module Directions
    DIRECTIONS = {
      "NORTH" => Vector2D.up.freeze,
      "SOUTH" => Vector2D.down.freeze,
      "EAST"  => Vector2D.right.freeze,
      "WEST"  => Vector2D.left.freeze
    }.freeze

    def self.[](key)
      DIRECTIONS[key]
    end

    def self.keys
      DIRECTIONS.keys
    end
  end

  class PlaceCommand < Command
    def execute(x, y, facing)
      return unless Directions.keys.include?(facing)
      position = Vector2D.new(x, y)
      direction = position + Directions[facing]
      entity.transform = Transform.new(position, direction)
    end

    def match?(input)
      input == "PLACE"
    end
  end

  class MoveCommand < Command
    def execute(*_)
      entity.transform.translate(Directions[facing]) if valid_move?
    end

    def next_move
      new_transform = entity.transform.dup
      new_transform.translate(Directions[facing])
    end

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

    def match?(input)
      input == "LEFT"
    end
  end

  class RightCommand < Command
    CLOCKWISE = -90.freeze # degrees

    def execute(*_)
      entity.transform.rotate(CLOCKWISE)
    end

    def match?(input)
      input == "RIGHT"
    end
  end

  class ReportCommand < Command
    def execute(*_)
      p "#{entity.transform.position},#{facing}"
    end

    def match?(input)
      input == "REPORT"
    end

    private

    def facing
      Compass.new(entity.transform).heading
    end
  end

  class NoActionCommand < Command
    def execute(*_)
    end

    def match?(_input)
      true
    end
  end
end
