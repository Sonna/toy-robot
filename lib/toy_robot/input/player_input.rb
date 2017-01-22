require "toy_robot/input/base"

module ToyRobot
  module Input
    class PlayerInput < Base
      def source
        $stdin.gets
      end
    end
  end
end
