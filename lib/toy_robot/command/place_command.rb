require "toy_robot/directions"
require "toy_robot/command/base"

module ToyRobot
  module Command
    class PlaceCommand < Base
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
  end
end
