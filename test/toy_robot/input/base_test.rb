require "test_helper"

module ToyRobot
  module Input
    class BaseTest < Minitest::Test
      def described_class
        Base
      end

      class DescribeAbstractClass < BaseTest
        def setup
          @subject = described_class.new
        end

        def test_subject_responds_to_process
          assert_respond_to(@subject, :process)
        end
      end

      class DescribeSubClass < BaseTest
        class FooInput < Base
          COMMANDS_STRING_IO = <<-COMMANDS.freeze
            PLACE 1,2,SOUTH
            MOVE
            LEFT
            RIGHT
            REPORT
            EXIT
          COMMANDS

          def initialize
            @source_string_io = StringIO.new(COMMANDS_STRING_IO)
          end

          def source
            @source_string_io.gets
          end
        end

        def setup
          @subject = FooInput.new
        end

        def test_process
          assert_equal ["PLACE", "1", "2", "SOUTH"], @subject.process
        end

        def test_process_loop
          expected_returned_inputs = [
            ["PLACE", "1", "2", "SOUTH"],
            ["MOVE"],
            ["LEFT"],
            ["RIGHT"],
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
end
