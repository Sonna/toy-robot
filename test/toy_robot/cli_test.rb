require "test_helper"

module ToyRobot
  class CLITest < Minitest::Test
    def test_bin_app
      assert `bin/app README.md`
    end

    def test_bin_app_returns_expected_output_for_readme_file
      actual_output = `bin/app README.md`
      expected_output = <<-SHELL
        "0,1,NORTH"
        "0,1,NORTH"
        "0,0,WEST"
        "3,3,NORTH"
        "3,3,NORTH"
        "1,2,SOUTH"
        "1,0,WEST"
      SHELL

      assert expected_output, actual_output
    end

    def test_bin_app_returns_expected_output_for_example_a_file
      actual_output = `bin/app test/fixtures/example_a.txt`
      expected_output = %("0,1,NORTH")

      assert expected_output, actual_output
    end

    def test_bin_app_returns_expected_output_for_example_b_file
      actual_output = `bin/app test/fixtures/example_b.txt`
      expected_output = %("0,1,WEST")

      assert expected_output, actual_output
    end

    def test_bin_app_returns_expected_output_for_example_c_file
      actual_output = `bin/app test/fixtures/example_c.txt`
      expected_output = %("3,3,NORTH")

      assert expected_output, actual_output
    end

    class CLI
      def self.run(filename = nil)
        input = filename ? FileInput.new(filename) : PlayerInput.new
        Robot.new(input)

        loop { break if input.update == "EXIT" }
      end
    end

    def test_bin_app_console
      stdout_output = local_io("MOVE\nREPORT\nEXIT") { CLI.run }
      assert_equal %("0,1,NORTH"\n), stdout_output
    end

    private

    def local_io(in_str)
      old_stdin, old_stdout = $stdin, $stdout
      $stdin = StringIO.new(in_str)
      $stdout = StringIO.new
      yield
      $stdout.string
    ensure
      $stdin, $stdout = old_stdin, old_stdout
    end
  end
end
