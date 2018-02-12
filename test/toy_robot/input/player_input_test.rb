require "test_helper"

module ToyRobot
  module Input
    class PlayerInputTest < Minitest::Test
      COMMANDS_STRING_IO = <<-COMMANDS.freeze
        PLACE 4,2,EAST
        RIGHT
        REPORT
        MOVE
        EXIT
        LEFT
      COMMANDS

      def described_class
        PlayerInput
      end

      def setup
        $stdin = StringIO.new(COMMANDS_STRING_IO)
        @subject = described_class.new
      end

      def teardown
        $stdin = STDIN
      end

      def test_process
        assert_equal ["PLACE", "4", "2", "EAST"], @subject.process
      end

      def test_process_loop
        expected_returned_inputs = [
          ["PLACE", "4", "2", "EAST"],
          ["RIGHT"],
          ["REPORT"],
          ["MOVE"],
          ["EXIT"]
        ]
        returned_inputs = []

        loop do
          returned_inputs << @subject.process
          break if returned_inputs.last == ["EXIT"]
        end

        assert_equal expected_returned_inputs, returned_inputs
      end
    end
  end
end
