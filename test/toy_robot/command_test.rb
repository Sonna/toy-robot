require "test_helper"

module ToyRobot
  class CommandTest < Minitest::Test
    class BarGrid
      attr_reader :entities
      attr_reader :min
      attr_reader :max

      def initialize(min, max)
        @entities = {}
        @min = min
        @max = max
      end

      def add_entity(vector2d, entity)
        @entities[vector2d] = entity if entity
      end

      def move(*_); end

      def valid_move?(entity)
        (min...max).cover?(entity.next_move.x) &&
          (min...max).cover?(entity.next_move.y)
      end
    end

    class BarEntity
      extend Forwardable
      def_delegators :@transform, :position

      attr_accessor :transform

      attr_reader :world

      def initialize(world)
        @transform = Transform.new(Vector2D.zero, Vector2D.up)
        @world = world
      end
    end

    def described_class
      Command::Base
    end

    def setup
      world = BarGrid.new(0, 5)
      entity = BarEntity.new(world)
      @subject = described_class.new(entity)
    end

    def test_subject_responds_to_execute
      assert_respond_to(@subject, :execute)
    end

    def test_subject_responds_to_match
      assert_respond_to(@subject, :match?)
    end

    class DescribeNoActionCommand < CommandTest
      def described_class
        Command::NoActionCommand
      end

      def test_match_is_true_when_input_is_anything
        assert @subject.match?("REPORT")
      end

      def test_match_is_false_when_input_is_nothing
        assert @subject.match?(" ")
      end

      def test_execute_no_action_does_nothing
        assert !@subject.execute
      end
    end
  end
end
