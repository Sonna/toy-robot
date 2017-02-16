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

        def test_subject_responds_to_control
          assert_respond_to(@subject, :control)
        end

        def test_subject_responds_to_entity
          assert_respond_to(@subject, :entity)
        end

        def test_subject_responds_to_update
          assert_respond_to(@subject, :update)
        end
      end

      class DescribeSubClass < BaseTest
        class FooInput < Base
          COMMANDS_STRING_IO = <<-COMMANDS
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

        class FooEntity
          def process(input, *_)
            %w(PLACE MOVE LEFT RIGHT REPORT).include?(input)
          end
        end

        def setup
          @subject = FooInput.new
          @subject.control(FooEntity.new)
        end

        def test_control_assigns_entity
          assert @subject.entity
        end

        def test_control_assigns_new_foo_entity
          new_entity = FooEntity.new
          @subject.control(new_entity)
          assert_equal new_entity, @subject.entity
        end

        def test_update
          assert_equal "PLACE", @subject.update
        end

        def test_update_loop
          expected_returned_inputs = %w(PLACE MOVE LEFT RIGHT REPORT EXIT)
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
end
