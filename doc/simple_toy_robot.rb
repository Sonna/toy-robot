#!/usr/bin/env ruby

COMMANDS = {
  "PLACE" => :place,
  "MOVE" => :move,
  "LEFT" => :left,
  "RIGHT" => :right,
  "REPORT" => :report,
  "DRAW" => :draw
}

SEPARATORS_REGEX = %r{[ |,\s*]}

TABLE = [
  ['.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.'],
  ['.', '.', '.', '.', '.']
]

class Robot
  EMPTY_TABLE_SPACE = '.'.freeze
  ICON = 'R'.freeze

  TURN = {
    'NORTH' => { 'LEFT' => 'WEST',  'RIGHT' => 'EAST' },
    'SOUTH' => { 'LEFT' => 'EAST',  'RIGHT' => 'WEST' },
    'EAST'  => { 'LEFT' => 'NORTH', 'RIGHT' => 'SOUTH' },
    'WEST'  => { 'LEFT' => 'SOUTH', 'RIGHT' => 'NORTH' }
  }.freeze

  MOVE = {
    'NORTH' => { x:  0, y:  1 },
    'SOUTH' => { x:  0, y: -1 },
    'EAST'  => { x:  1, y:  0 },
    'WEST'  => { x: -1, y:  0 }
  }.freeze

  attr_reader :x
  attr_reader :y
  attr_reader :facing
  attr_reader :table

  def initialize(table, x = 0, y = 0, facing = 'NORTH')
    @table = table
    @x = x
    @y = y
    @facing = facing
    place(x, y, facing)
  end

  def place(new_x, new_y, facing)
    @table[x][y] = EMPTY_TABLE_SPACE.dup

    @x = new_x.to_i
    @y = new_y.to_i
    @facing = @facing.to_s

    @table[x][y] = ICON.dup
  end

  def move(*_)
    @table[x][y] = EMPTY_TABLE_SPACE

    @x += MOVE[@facing][:x]
    @y += MOVE[@facing][:y]

    @x -= MOVE[@facing][:x] if x < 0 || x > 4
    @y -= MOVE[@facing][:y] if x < 0 || x > 4

    @table[x][y] = ICON.dup
  end

  def left(*_)
    @facing = TURN[facing]['LEFT']
  end

  def right(*_)
    @facing = TURN[facing]['RIGHT']
  end

  def report(*_)
    puts "#{@x}, #{@y}, #{@facing}"
  end

  def draw
    canvas = []
    (0..4).reverse_each do |y|
      (0..4).each do |x|
        canvas << table[x][y]
      end
      canvas << "\n"
    end
    puts canvas.join
  end
end

# def draw(table)
#   canvas = []
#   (0..4).reverse_each do |y|
#     (0..4).each do |x|
#       canvas << table[x][y]
#     end
#     canvas << "\n"
#   end
#   canvas.join
# end

# puts draw(table) + "\n"

# robot.report # => "0, 0, NORTH"
# robot.move # => "R"
# robot.report # => "0, 1, NORTH"

# puts draw(table) + "\n"

# robot.right
# robot.move
# robot.report # => "1, 1, EAST"

# puts draw(table) + "\n"

filename = ARGV.first
input = !filename ? $stdin : File.new(filename)

table = TABLE.dup
robot = Robot.new(table)

loop do
  break if input.is_a?(File) && input.eof?
  command_method, *args = input.gets.chomp.split(SEPARATORS_REGEX)
  command = COMMANDS[command_method]
  robot.method(command).call(*args) if command
  break if command_method == "EXIT"
end


# >> .....
# >> .....
# >> .....
# >> .....
# >> R....
# >>
# >> .....
# >> .....
# >> .....
# >> R....
# >> .....
# >>
# >> .....
# >> .....
# >> .....
# >> .R...
# >> .....
# >>
