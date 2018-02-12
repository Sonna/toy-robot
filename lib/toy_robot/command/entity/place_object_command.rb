require "toy_robot/directions"
require "toy_robot/command/base"
require "toy_robot/compass"
require "toy_robot/obstacle"

module ToyRobot
  module Command
    module Entity
      class PlaceObjectCommand < Base
        def execute(*_)
          return unless valid_move?
          entity.world.add_entity(
            next_move.position, Obstacle.new(entity.world, next_move)
          )
        end

        def match?(input)
          input == "PLACE_OBJECT"
        end

        def next_move
          new_transform = entity.transform.dup
          new_transform.translate(Directions[facing])
        end

        def next_position
          next_move.position
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
