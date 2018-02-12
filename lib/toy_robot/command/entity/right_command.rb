require "toy_robot/command/base"

module ToyRobot
  module Command
    module Entity
      class RightCommand < Base
        CLOCKWISE = -90 # degrees

        def execute(*_)
          entity.transform.rotate(CLOCKWISE)
        end

        def match?(input)
          input == "RIGHT"
        end
      end
    end
  end
end
