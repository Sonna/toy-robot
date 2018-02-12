require "test_helper"

module ToyRobot
  class CellTest < Minitest::Test
    BooBazGrid = Struct.new(:min, :max)

    class BooBazEntity
      def draw
        "E"
      end
    end

    class FooFangEntity; end

    def described_class
      Cell
    end

    class DescribeInstanceMethods < CellTest
      def setup
        world = BooBazGrid.new(0,5)
        entity = BooBazEntity.new
        @subject = described_class.new(world, entity)
      end

      def test_subject_responds_to_draw
        assert_respond_to(@subject, :draw)
      end

      def test_subject_responds_to_entity
        assert_respond_to(@subject, :entity)
      end

      def test_subject_responds_to_entity_equal
        assert_respond_to(@subject, :entity=)
      end

      def test_subject_responds_to_occupied
        assert_respond_to(@subject, :occupied?)
      end

      def test_subject_draw
        assert_equal "E", @subject.draw
      end

      def test_subject_draw_when_has_no_entity
        world = BooBazGrid.new(0,5)
        subject = described_class.new(world)
        assert_equal ".", subject.draw
      end

      def test_subject_entity_reassignment
        world = BooBazGrid.new(0,5)
        entity = BooBazEntity.new
        subject = described_class.new(world, entity)

        entity = FooFangEntity.new
        subject.entity = entity

        assert_equal entity, subject.entity
      end

      def test_subject_occupied_when_has_entity
        assert @subject.occupied?
      end

      def test_subject_occupied_returns_entity
        world = BooBazGrid.new(0,5)
        entity = BooBazEntity.new
        subject = described_class.new(world, entity)

        assert_equal entity, subject.occupied?
      end

      def test_subject_not_occupied_when_has_no_entity
        world = BooBazGrid.new(0,5)
        subject = described_class.new(world)
        refute subject.occupied?
      end
    end
  end
end
