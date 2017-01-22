require "test_helper"

module ToyRobot
  module Input
    class FileInputTest < Minitest::Test
      class BazEntity
        def command(*_)
          true
        end
        alias_method :place, :command
        alias_method :move, :command
        alias_method :left, :command
        alias_method :right, :command
        alias_method :report, :command
      end

      def described_class
        FileInput
      end

      def filename
        "test/fixtures/example_a.txt"
      end

      def setup
        @subject = described_class.new(filename)
        @subject.control(BazEntity.new)
      end

      def test_update
        assert_equal "PLACE", @subject.update
      end

      def test_update_loop
        expected_returned_inputs = %w(PLACE MOVE REPORT EXIT)
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
