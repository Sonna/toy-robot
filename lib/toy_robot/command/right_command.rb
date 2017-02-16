require "toy_robot/command/base"

module ToyRobot
  module Command
    class RightCommand < Base
      CLOCKWISE = -90.freeze # degrees

      def execute(*_)
        entity.transform.rotate(CLOCKWISE)
      end

      def match?(input)
        input == "RIGHT"
      end
    end
  end
end
