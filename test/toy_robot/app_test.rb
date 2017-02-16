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
