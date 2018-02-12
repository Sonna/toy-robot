require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeExitCommand < CommandTest
      class FooApp
        def initialize
          @running = true
        end

        def quit!
          @running = false
        end

        def run
          p "pandas" if @running
        end
      end

      def described_class
        Command::App::ExitCommand
      end

      def test_match_is_true_when_input_is_exit
        assert @subject.match?("EXIT")
      end

      def test_match_is_false_when_input_is_not_exit
        assert !@subject.match?("QUIT")
      end

      def test_execute_exit_command
        $stdout = StringIO.new
        app = FooApp.new
        subject = described_class.new(app)

        subject.execute

        assert_equal "", $stdout.string
      ensure
        $stdout = STDOUT
      end

      def test_no_more_than_one_pandas
        $stdout = StringIO.new
        app = FooApp.new
        subject = described_class.new(app)

        app.run

        assert_equal %("pandas"\n), $stdout.string

        subject.execute
        app.run

        assert_equal %("pandas"\n), $stdout.string
      ensure
        $stdout = STDOUT
      end
    end
  end
end
