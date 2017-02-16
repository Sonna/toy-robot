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

      class BarEntity
        def process(input, *_)
          %w(PLACE MOVE LEFT RIGHT REPORT).include?(input)
        end
      end

      def described_class
        PlayerInput
      end

      def setup
        $stdin = StringIO.new(COMMANDS_STRING_IO)
        @subject = described_class.new
        @subject.control(BarEntity.new)
      end

      def teardown
        $stdin = STDIN
      end

      def test_update
        assert_equal "PLACE", @subject.update
      end

      def test_update_loop
        expected_returned_inputs = %w(PLACE RIGHT REPORT MOVE EXIT)
        returned_inputs = []

        loop do
          returned_inputs << @subject.update
          break if returned_inputs.last == "EXIT"
        end

        assert_equal expected_returned_inputs, returned_inputs
      end
    end
  end
end
