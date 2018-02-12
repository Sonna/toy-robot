Previous versions of `Robot` class
==================================

The following are quick snippets of the different stages / versions of the Robot
class as it evolved during its development.

Version 1
---------
- see commit 229c3e4559b0956f57a4becc4af23be0b33437a9
- or commit 7aed2e7e70db2ea963af2fd5f805b07454270cb3

```ruby
require "toy_robot/point"

module ToyRobot
  class Robot
    attr_reader :facing
    attr_reader :position

    DIRECTIONS = {
      "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right: "EAST",  valid_move?: ->(context) { context.next_move.y <= 5 } },
      "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right: "WEST",  valid_move?: ->(context) { context.next_move.y >= 0 } },
      "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH", valid_move?: ->(context) { context.next_move.x <= 5 } },
      "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH", valid_move?: ->(context) { context.next_move.x >= 0 } }
    }.freeze

    def initialize
      @facing = "NORTH"
      @position = Point.new(0, 0)
    end

    def move(*_)
      @position = next_move if valid_move?
    end

    def next_move
      @position + DIRECTIONS[facing][:move]
    end

    def left(*_)
      @facing = DIRECTIONS[facing][:left]
    end

    def right(*_)
      @facing = DIRECTIONS[facing][:right]
    end

    def place(x, y, facing)
      return unless DIRECTIONS.keys.include?(facing)
      @position = Point.new(x, y)
      @facing = facing
    end

    def report
      p "#{position},#{facing}"
    end

    def valid_move?
      DIRECTIONS[facing][:valid_move?].call(self)
    end
  end
end
```

Version 2
---------
- see commit 9dbb379d9b81d09eb3af1003d4cabc58a87a9dbb

```ruby
require "toy_robot/point"

module ToyRobot
  class Robot
    attr_reader :facing
    attr_reader :input
    attr_reader :position
    attr_reader :world

    DIRECTIONS = {
      "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right:  "EAST" },
      "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right:  "WEST" },
      "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH" },
      "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH" }
    }.freeze

    def initialize(world, input)
      @facing = "NORTH"
      @position = Point.new(0, 0)

      @world = world
      @input = input
      @input.control(self)
    end

    def move(*_)
      @position = next_move if valid_move?
    end

    def next_move
      @position + DIRECTIONS[facing][:move]
    end

    def left(*_)
      @facing = DIRECTIONS[facing][:left]
    end

    def right(*_)
      @facing = DIRECTIONS[facing][:right]
    end

    def place(x, y, facing)
      return unless DIRECTIONS.keys.include?(facing)
      @position = Point.new(x, y)
      @facing = facing
    end

    def report
      p "#{position},#{facing}"
    end

    def valid_move?
      world.valid_move?(self)
    end
  end
end
```

Version 3
---------
- see current project on `master` branch

```ruby
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
      place = Command::PlaceCommand.new(self)
      move = Command::MoveCommand.new(self)
      left = Command::LeftCommand.new(self)
      right = Command::RightCommand.new(self)
      report = Command::ReportCommand.new(self)

      no_action = Command::NoActionCommand.new(self)

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

```
