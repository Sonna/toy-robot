require "toy_robot/directions"
require "toy_robot/command/base"
require "toy_robot/compass"

module ToyRobot
  module Command
    module Entity
      class RemoveObjectCommand < Base
        def execute(*_)
          entity.world.remove_entity(next_move.position)
        end

        def match?(input)
          input == "REMOVE_OBJECT"
        end

        def next_move
          new_transform = entity.transform.dup
          new_transform.translate(Directions[facing])
        end

        def next_position
          next_move.position
        end

        private

        def facing
          Compass.new(entity.transform).heading
        end
      end
    end
  end
end
