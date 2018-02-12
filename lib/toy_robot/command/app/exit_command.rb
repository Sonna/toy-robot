require "toy_robot/command/base"

module ToyRobot
  module Command
    module App
      class ExitCommand < Base
        def execute(*_)
          # app.quit!
          entity.quit!
        end

        def match?(input)
          input == "EXIT"
        end
      end
    end
  end
end
