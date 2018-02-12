require "toy_robot/command/base"

module ToyRobot
  module Command
    module Entity
      class ReportCommand < Base
        def execute(*_)
          p "#{entity.transform.position},#{facing}"
        end

        def match?(input)
          input == "REPORT"
        end

        private

        def facing
          Compass.new(entity.transform).heading
        end
      end
    end
  end
end
