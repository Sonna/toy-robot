require "toy_robot/command/base"

module ToyRobot
  module Command
    class NoActionCommand < Base
      def execute(*_)
      end

      def match?(_input)
        true
      end
    end
  end
end
