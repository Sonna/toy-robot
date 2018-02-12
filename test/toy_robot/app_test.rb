require "test_helper"

module ToyRobot
  class AppTest < Minitest::Test
    def described_class
      App
    end

    def test_bin_app_console
      stdout_output = local_io("MOVE\nREPORT\nEXIT") { described_class.run }
      assert_equal %("0,1,NORTH"\n), stdout_output
    end

    def test_bin_app_console_render_default_value
      stdout_output = local_io("DRAW\nEXIT") { described_class.run }
      expected_drawn_grid = <<-STRING.gsub(/^        /, "")
        .....
        .....
        .....
        .....
        R....
      STRING

      assert_equal expected_drawn_grid, stdout_output
    end

    def test_bin_app_console_does_not_render_every_turn
      stdout_output = local_io("MOVE\nDRAW\nRIGHT\nMOVE\nREPORT\nEXIT") do
       described_class.run
     end

      expected_stdout_output = <<-STRING.gsub(/^        /, "")
        .....
        .....
        .....
        R....
        .....
        "1,1,EAST"
      STRING

      assert_equal expected_stdout_output, stdout_output
    end

    class DescribeMethods < AppTest
      def setup
        @subject = described_class.new
      end

      def test_subject_responds_to_input
        assert_respond_to(@subject, :render!)
      end
    end

    private

    def local_io(in_str)
      old_stdin = $stdin
      old_stdout = $stdout
      $stdin = StringIO.new(in_str)
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdin = old_stdin
      $stdout = old_stdout
    end
  end
end
