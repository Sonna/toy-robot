# Design doc

```
  Robot
  - @position = (0,0)
  - @facing = NORTH
```

**5x5 Grid**

      y
      ^
(5,0) *________________________* (5,5)
      |    |    |    |    |    |
      |    |    |    |    |    |
      |----|----|----|----|----|
      |    |    |    |    |    |
      |    |    |    |    |    |
      |----|----|----|----|----|
      |    |    |    |    |    |
      |    |    |    |    |    |
      |----|----|----|----|----|
      |    |    |    |    |    |
      |    |    |    |    |    |
(0,0) *----|----|----|----|----|
      |    |    |    |    |    |
      |    |    |    |    |    |
(0,0) *----*-------------------* (0,5) > x
         (1,0)

Moves
-----
LEFT ↰     ↱ RIGHT
        N
        ^
        |
   E <--+--> W
        |
        v
        S

- Facing North
  ```
    #        x, y
    MOVE = (+0,+1), LEFT = EAST, RIGHT = WEST
  ```

- Facing South
  ```
    #        x, y
    MOVE = (+0,-1), LEFT = WEST, RIGHT = EAST
  ```

- Facing East
  ```
    #        x, y
    MOVE = (+1,+0), LEFT = NORTH, RIGHT = SOUTH
  ```

- Facing WEST
  ```
    #        x, y
    MOVE = (-1,+0), LEFT = SOUTH, RIGHT = NORTH
  ```

- `(0,0)` represents a `Point` on the `Map` or `Gird` / `Table`
- `NORTH`, `SOUTH`, `EAST` and `WEST` could be able referenced as `Point` or as
  `Commands` (or just regular symbols)
- If the facing direction is presented as a `Point` it would:
  - Equal the next MOVE position; grat for error checking & updating the position
  - Could simplify turning LEFT or RIGHT to updating the facing `Point` with?

at (0,0) if NORTH:  LEFT = (-1,-1) & RIGHT = (+1,-1)
            (0,1)  (-1,0)            (1,0)

at (0,0) if SOUTH:  LEFT = (+1,+1) & RIGHT = (+1,-1)
            (0,-1)  (1,0)            (-1,0)

at (0,0) if EAST:   LEFT = (-1,-1) & RIGHT = (+1,-1)
            (-1,0)  (0,1)            (0,-1)

at (0,0) if WEST:   LEFT = (-1,-1) & RIGHT = (+1,+1)
            (1,0)  (0,-1)            (0,1)

This describes rotations in Cartesian plane

      ^
 Sin  |  All
   <--+-->
 Tan  |  Cos
      v

_For calculating angles?_

- The `Robot` is outside the `Grid` if its next MOVE's `z` or `y` is less than
  0 (or equal to -1) or greater than 5 (or equal to 5)
  - Or I could define a `Boundary` & check to see if the next `MOVE` lands within it

  ```
    if facing.x == -1 || facing.y == -1 || facing.x == 6 || facing.x == 6

    # Or

    if facing.x in (0..5) && facing.y in (0..5)
  ```

## initial draft example

```ruby
    class Robot
      DIRECTIONS = [NORTH, EAST, SOUTH, WEST]

      attr_reader :facing_index

      def initialize
        @facing_index = 0
      end

      def left
        @facing_index = (@facing_index - 1) % 4
      end

      def right
        @facing_index = (@facing_index + 1) % 4
      end

      def facing
        DIRECTIONS[@facing_index]
      end
    end
    # use modulus to avoid implementing a linked list, if possible
```

## second draft example

```ruby
    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

      def self.+(other)
        Point.new(x + other.x, y + other.y)
      end
    end

    class Grid
      MAX = 5
      MIN = 0

      attr_reader :max, :min

      def initialize(min, max)
        @min = min || MIN
        @max = max || MAX
      end
    end

    class Robot
      # @facing = :north # "NORTH"
      attr_reader :facing # :north # "NORTH"
      attr_reader :position # Point(0, 0)

      DIRECTIONS = {
        north: { move: Point( 0, 1), left:  :west, right: :east,  valid_move?: { _move.x > 6 } },
        south: { move: Point( 0,-1), left:  :east, right: :west,  valid_move?: { _move.x > 0 } },
        east:  { move: Point( 1, 0), left: :north, right: :south, valid_move?: { _move.x < 6 } },
        west:  { move: Point(-1, 0), left: :south, right: :north, valid_move?: { _move.x < 0 } }
      }.freeze

      def initialize
        @facing = :north # "NORTH"
        @position = Point.new(0, 0)
      end

      def move # (*_)
        # @position += DIRECTIONS[facing][:move] if valid_move?
        @position = _move if valid_move?
      end

      def left # (*_)
        @facing = DIRECTIONS[facing][:left]
      end

      def right # (*_)
        @facing = DIRECTIONS[facing][:right]
      end

      def place(x, y, facing) # (*_)
        @position = Point.new(x, y)
        @facing = facing # "NORTH"
      end

      # def valid_move?
      #   _move.x >= 0 && _move.x <= 5 && # :east  / :west
      #     _move.y >= 0 && _move.y <= 5  # :north / :south
      # end

      # Grid.max | min

      # def valid_move?
      #   _move.x >= grid.min && _move.x <= grid.max && # :east  / :west
      #     _move.y >= grid.min && _move.y <= grid.max  # :north / :south
      # end

      def valid_move?
        DIRECTIONS[facing][:valid_move?].call
      end

      private

      def _move
        @position + DIRECTIONS[facing][:move]
      end
    end

    # == Example input
    #
    # PLACE X,Y,F
    # MOVE
    # LEFT
    # RIGHT
    # REPORT

    # main.rb
    input = gets
    # Or
    input, *args = gets.chomp

    COMMANDS = {
      "PLACE": :place,
      "MOVE": :move,
      "LEFT": :left,
      "RIGHT": :right,
      "REPORT": :report,
    }

    COMMAND[input].call(args)

    # def Robot.postion(x,y,facing)
    def Robot.place(*args) #?
      x, y, facing = args.split(",")
      postion = Point.new(x,y) # should Point validate itself?
    end

    # main.rb
    if !ARGV
      loop do
        input, *args = gets.chomp
        break if input == "EXIT"
        robot.method(COMMANDS[input]).call(args)
      end
    else
      # commands = File.new(ARGV, "r")
      File.readlines(ARGV).each do |line|
        robot.method(COMMADN[input]).call(args)
      end
    end

```

## third draft example

```ruby
```
