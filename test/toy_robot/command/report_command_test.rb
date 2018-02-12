require File.expand_path("toy_robot/command_test.rb", TEST_DIRECTORY)

module ToyRobot
  class CommandTest < Minitest::Test
    class DescribeReportCommand < CommandTest
      def described_class
        Command::ReportCommand
      end

      def test_match_is_true_when_input_is_report
        assert @subject.match?("REPORT")
      end

      def test_match_is_false_when_input_is_not_report
        assert !@subject.match?("PLACE")
      end

      def test_facing_has_default_value
        assert_equal "NORTH", @subject.send(:facing)
      end

      def test_execute_report_command
        $stdout = StringIO.new
        assert_equal "0,0,NORTH", @subject.execute
      ensure
        $stdout = STDOUT
      end
    end
  end
end
