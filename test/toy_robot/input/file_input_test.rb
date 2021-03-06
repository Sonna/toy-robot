require "test_helper"

module ToyRobot
  module Input
    class FileInputTest < Minitest::Test
      def described_class
        FileInput
      end

      def filename
        "test/fixtures/example_a.txt"
      end

      def setup
        @subject = described_class.new(filename)
      end

      def test_process
        assert_equal ["PLACE", "0", "0", "NORTH"], @subject.process
      end

      def test_process_loop
        expected_returned_inputs = [
          ["PLACE", "0", "0", "NORTH"],
          ["MOVE"],
          ["REPORT"],
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
