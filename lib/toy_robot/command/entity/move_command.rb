require "toy_robot/directions"
require "toy_robot/command/base"
require "toy_robot/compass"

module ToyRobot
  module Command
    module Entity
      class MoveCommand < Base
        def execute(*_)
          return unless valid_move?
          entity.world.move(self)
          entity.transform.translate(Directions[facing])
        end

        def match?(input)
          input == "MOVE"
        end

        def next_move
          new_transform = entity.transform.dup
          new_transform.translate(Directions[facing])
        end

        def next_position
          next_move.position
        end

        def position
          entity.transform.position
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
end
