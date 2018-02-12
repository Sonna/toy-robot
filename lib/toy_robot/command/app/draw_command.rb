require "toy_robot/command/base"

module ToyRobot
  module Command
    module App
      class DrawCommand < Base
        def execute(*_)
          entity.render!
        end

        def match?(input)
          input == "DRAW"
        end
      end
    end
  end
end
