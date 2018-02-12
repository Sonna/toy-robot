module ToyRobot
  module Command
    class Base
      attr_reader :entity

      def initialize(entity)
        @entity = entity
      end

      def match?(input)
        # does nothing
      end

      def execute(*_)
        # does nothing
      end
    end
  end
end
