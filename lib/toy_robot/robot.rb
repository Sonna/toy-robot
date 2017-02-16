require "toy_robot/command"
require "toy_robot/transform"

module ToyRobot
  class Robot
    extend Forwardable
    def_delegators :@transform, :position

    attr_accessor :transform

    attr_reader :input
    attr_reader :world

    NORTH  = Vector2D.up.freeze
    ORIGIN = Vector2D.zero.freeze

    def initialize(world, input)
      @transform = Transform.new(ORIGIN, NORTH)

      @world = world
      @input = input
      @input.control(self)
    end

    def commands
      place = PlaceCommand.new(self)
      move = MoveCommand.new(self)
      left = LeftCommand.new(self)
      right = RightCommand.new(self)
      report = ReportCommand.new(self)

      no_action = NoActionCommand.new(self)

      [place, move, left, right, report, no_action]
    end

    def command_for_input(input)
      commands.find { |command| command.match?(input) }
    end

    def process(input, *args)
      command_for_input(input).execute(*args)
    end
  end
end
