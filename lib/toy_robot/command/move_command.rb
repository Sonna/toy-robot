require "toy_robot/directions"
require "toy_robot/command/base"
require "toy_robot/compass"

module ToyRobot
  module Command
    class MoveCommand < Base
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
  end
end
