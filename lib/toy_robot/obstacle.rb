require "toy_robot/transform"

module ToyRobot
  class Obstacle
    extend Forwardable
    def_delegators :@transform, :position

    attr_accessor :transform

    attr_reader :world

    def initialize(world, transform = Transform.new(Vector2D.zero))
      @world = world
      @transform = transform
      world.add_entity(transform.position, self)
    end

    def ==(other)
      world == other.world && transform == other.transform
    end
    alias_method :eql?, :==

    def draw
      "O"
    end
  end
end
