require "test_helper"

module ToyRobot
  class GridTest < Minitest::Test
    def described_class
      Grid
    end

    def setup
      @subject = described_class.new
    end

    class DescribeMethods < GridTest
      def test_subject_responds_to_min
        assert_respond_to(@subject, :min)
      end

      def test_subject_responds_to_max
        assert_respond_to(@subject, :max)
      end
    end

    class DescibedRobotInitializedAttributes < GridTest
      def test_min_has_default_value
        assert_equal 0, @subject.min
      end

      def test_max_has_default_value
        assert_equal 5, @subject.max
      end

      def test_set_min_value_on_initialize
        subject = described_class.new(1)
        assert_equal 1, subject.min
      end

      def test_set_max_value_on_initialize
        subject = described_class.new(0, 6)
        assert_equal 6, subject.max
      end
    end
  end
end
