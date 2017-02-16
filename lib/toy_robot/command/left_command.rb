require "toy_robot/command/base"

module ToyRobot
  module Command
    class LeftCommand < Base
      ANTI_CLOCKWISE = 90 # degrees

      def execute(*_)
        entity.transform.rotate(ANTI_CLOCKWISE)
      end

      def match?(input)
        input == "LEFT"
      end
    end
  end
end
