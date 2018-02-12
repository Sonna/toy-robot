require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeDrawCommand < CommandTest
      FooBarGrid = Struct.new(:draw_text) do
        def draw(*_)
          draw_text
        end
      end

      FooScene = Struct.new(:entity) do
        def render!
          p entity.draw
        end
      end

      def described_class
        Command::App::DrawCommand
      end

      def test_match_is_true_when_input_is_report
        assert @subject.match?("DRAW")
      end

      def test_match_is_false_when_input_is_not_report
        assert !@subject.match?("TABLE")
      end

      def test_execute_draw_command
        world = FooBarGrid.new("hello world")
        entity = BarEntity.new(world)
        scene = FooScene.new(world)

        subject = described_class.new(scene)

        $stdout = StringIO.new
        assert_equal "hello world", subject.execute
      ensure
        $stdout = STDOUT
      end
    end
  end
end
