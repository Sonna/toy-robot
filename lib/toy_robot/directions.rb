require "toy_robot/vector2d"

module ToyRobot
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
end
