require "forwardable"

module ToyRobot
  # class Compass < SimpleDelegator
  class Compass
    extend Forwardable

    HEADINGS = [
      "EAST",
      "NORTH-EAST",
      "NORTH",
      "NORTH-WEST",
      "WEST",
      "SOUTH-WEST",
      "SOUTH",
      "SOUTH-EAST"
    ].freeze

    def_delegators :@transform, :position, :target

    def initialize(transform)
      @transform = transform
    end

    # == References:
    # http://stackoverflow.com/questions/1437790/how-to-snap-a-directional-2d-vector-to-a-compass-n-ne-e-se-s-sw-w-nw
    # http://gamedev.stackexchange.com/questions/49290/whats-the-best-way-of-transforming-a-2d-vector-into-the-closest-8-way-compass-d
    def heading
      px = target.x - position.x # v2.x - v1.x
      py = target.y - position.y # v2.y - v1.y
      angle = Math.atan2(py, px)
      octant = (8 * angle / (2 * Math::PI) + 8).round % 8

      HEADINGS[octant]
    end
  end
end
