require "toy_robot/command"
require "toy_robot/transform"

module ToyRobot
  class Robot
    extend Forwardable
    def_delegators :@transform, :position

    attr_accessor :transform

    attr_reader :world

    NORTH  = Vector2D.up.freeze
    ORIGIN = Vector2D.zero.freeze

    def initialize(world)
      @transform = Transform.new(ORIGIN, NORTH)
      @world = world
    end
  end
end
