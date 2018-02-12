require "toy_robot/input/base"

module ToyRobot
  module Input
    class FileInput < Base
      attr_reader :file

      def initialize(filename)
        @file = File.new(filename)
      end

      def source
        return "EXIT" if file.eof?
        file.gets
      end
    end
  end
end
