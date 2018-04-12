#!/usr/bin/env ruby

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  # def self.+(other)
  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  def to_s
    "#{x},#{y}"
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
    # "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right: "EAST",  valid_move?: -> { _move.y > 6 } },
    # "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right: "WEST",  valid_move?: -> { _move.y > 0 } },
    # "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH", valid_move?: -> { _move.x < 6 } },
    # "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH", valid_move?: -> { _move.x < 0 } }
    "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right: "EAST",  valid_move?: ->(context) { context.next_move.y <= 5 } },
    "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right: "WEST",  valid_move?: ->(context) { context.next_move.y >= 0 } },
    "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH", valid_move?: ->(context) { context.next_move.x <= 5 } },
    "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH", valid_move?: ->(context) { context.next_move.x >= 0 } }
  }.freeze

  def initialize
    @facing = "NORTH" # :north
    @position = Point.new(0, 0)
  end

  def move(*_)
    # @position += DIRECTIONS[facing][:move] if valid_move?
    @position = next_move if valid_move?
  end

  def left(*_)
    @facing = DIRECTIONS[facing][:left]
  end

  def right(*_)
    @facing = DIRECTIONS[facing][:right]
  end

  def place(x, y, facing) # (*_)
    # return unless x.is_a?(Integer) && y.is_a?(Integer) && DIRECTIONS.keys.include?(facing)
    return unless DIRECTIONS.keys.include?(facing)
    @position = Point.new(x, y)
    @facing = facing # "NORTH"
  end

  # def nil
  # end

  # X,Y and F
  def report
    p "#{position},#{facing}"
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
    DIRECTIONS[facing][:valid_move?].call(self)
  end

  # private

  # def _move
  def next_move
    # p @position, DIRECTIONS[facing][:move]
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
# input = gets
# Or
# input, *args = gets.chomp

COMMANDS = {
  "PLACE" => :place,
  "MOVE" => :move,
  "LEFT" => :left,
  "RIGHT" => :right,
  "REPORT" => :report,
  # nil => :nil
}

# COMMANDS[input]*.call(args)

# # def Robot.postion(x,y,facing)
# def Robot.place(*args) #?
#   x, y, facing = args.split(",")
#   postion = Point.new(x,y) # should Point validate itself?
# end

# main.rb
filename = ARGV.first
robot = Robot.new

# if !ARGV
if !filename
  loop do
    # input, *args = gets.chomp.split(" ")
    input, *args = gets.chomp.split(%r{[ |,\s*]})
    # p input, args
    break if input == "EXIT"
    robot.method(COMMANDS[input]).call(*args) if COMMANDS[input]
  end
else
  # commands = File.new(ARGV, "r")
  File.readlines(filename).each do |line|
    input, *args = line.strip.split(%r{[ |,\s*]})
    # p input, args
    robot.method(COMMANDS[input]).call(*args) if COMMANDS[input]
  end
end
