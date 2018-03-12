require "test_helper"

module ToyRobot
  class CLITest < Minitest::Test
    def test_bin_app
      assert `bin/app README.md`
    end

    # rubocop:disable Metrics/MethodLength
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
    # rubocop:enable Metrics/MethodLength

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

    def test_bin_app_returns_expected_output_for_example_d_file
      actual_output = `bin/app test/fixtures/example_c.txt`
      expected_output =  <<-SHELL
        "0,0,NORTH"
        .....
        .....
        .....
        .....
        R....
      SHELL

      assert expected_output, actual_output
    end

    def test_bin_app_returns_expected_output_for_example_e_file
      actual_output = `bin/app test/fixtures/example_c.txt`
      expected_output =  <<-SHELL
        "0,0,NORTH"
        .....
        .....
        .....
        O....
        R....
      SHELL

      assert expected_output, actual_output
    end

    def test_bin_app_returns_expected_output_for_example_f_file
      actual_output = `bin/app test/fixtures/example_c.txt`
      expected_output =  <<-SHELL
        "0,0,NORTH"
        .....
        .....
        .....
        O....
        R....
        .....
        .....
        .....
        .....
        R....
      SHELL

      assert expected_output, actual_output
    end
  end
end
