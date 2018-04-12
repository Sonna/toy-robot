#!/usr/bin/env ruby
# encoding: utf-8

# `encoding: utf-8` fixes `-:52: invalid multibyte char (US-ASCII)`

local_lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(local_lib) unless $LOAD_PATH.include?(local_lib)

require "cell"
require "camera"
require "object_pool"
require "point"

class Screen
  attr_reader :canvas
  attr_reader :object_pool
  attr_reader :world

  attr_reader :height
  attr_reader :width

  HEIGHT = 6
  WIDTH = 8

  def initialize(object_pool, width = WIDTH, height = HEIGHT)
    # @canvas = Array.new(WIDTH) { Array.new(HEIGHT) { " " } }
    @canvas = Array.new(width) { Array.new(height) { " " } }
    @object_pool = object_pool

    @height = height
    @width = width
  end

  def render
    object_pool.each { |game_object| game_object.draw(canvas, width, height) }
    canvas.map { |row| row.join }.join("\n")
    # object_pool.each do |game_object|
    #   # canvas[game_object.position.x][game_object.position.y] = game_object.draw
    #   game_object.draw(canvas, width, height)
    # end
    # canvas.map { |row| row.join }.join("\n") # !> assigned but unused variable - pos
  end
 # !> assigned but unused variable - off_x
  # def max_x # !> assigned but unused variable - off_y
  #   WIDTH
  # end

  # def max_y
  #   HEIGHT
  # end
end

require "minitest/autorun"

class TestScreen < Minitest::Test
  def test_render_cell_on_screen
    cell = Cell.new Point.new(4, 3)
    object_pool = ObjectPool.new
    object_pool << cell
    screen = Screen.new(object_pool)

    expected_output =
      "       \n" \
      "       \n" \
      "       \n" \
      "       \n" \
      "   ┏━┓ \n" \
      "   ┃ ┃ \n" \
      "   ┗━┛ \n" \
      "       \n" \
      "       \n"
    actual_output = screen.render
    assert expected_output, actual_output
  end
end

# cell = Cell.new Point.new(Screen::WIDTH/2, Screen::HEIGHT/2)
object_pool = ObjectPool.new

# cell = Cell.new object_pool, Point.new(4, 3)

# object_pool << cell
object_pool.objects # => #<Set: {}> # !> method redefined; discarding old x
screen = Screen.new(object_pool, 20, 20)
camera = Camera.new(screen)
object_pool.camera = camera
# puts screen.render # !> method redefined; discarding old y

require "grid"
table = Grid.new(object_pool)
object_pool.world = table
# object_pool << table

# puts screen.render

require "robot"
robot = Robot.new(object_pool)
object_pool << robot

robot.position # => #<Point:0x007fb8a193ac18 @x=0, @y=0>
# robot.move
# robot.right
# robot.move
# robot.move

puts screen.render
robot.move
robot.move
robot.move # !> assigned but unused variable - pos
robot.right
robot.move # !> assigned but unused variable - off_x
robot.move # !> assigned but unused variable - off_y
robot.move
robot.left
robot.left
robot.left
robot.move
puts screen.render
# >> 1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
# >> "robot rowi: 0, coli: 3, x: 0, y: 0, _x: 1, _y: 10"
# >> "robot rowi: 3, coli: 3, x: 0, y: 0, _x: 1, _y: 13"
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃18┃21┃24┃27┃30
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃15┃18┃21┃24┃27
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃12┃15┃18┃21┃24
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃↑┃┃12┃15┃18┃21
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃R┃┃9┃┃12┃15┃18
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> "robot rowi: 3, coli: 3, x: 3, y: 2, _x: 10, _y: 7"
# >> "robot rowi: 6, coli: 3, x: 3, y: 2, _x: 10, _y: 10"
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃18┃21┃24┃27┃30
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃15┃18┃21┃24┃27
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃12┃15┃18┃R1┃24
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃9┃┃12┃15┃↓8┃21
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> ┏━┓┏━┓┏━┓┏━┓┏━┓
# >> ┃6┃┃9┃┃12┃15┃18
# >> ┗━┛┗━┛┗━┛┗━┛┗━┛
# >> Run options: --seed 35660
# >>
# >> # Running:
# >>
# >> E
# >>
# >> Finished in 0.001013s, 987.0869 runs/s, 0.0000 assertions/s.
# >>
# >>   1) Error:
# >> TestScreen#test_render_cell_on_screen:
# >> ArgumentError: wrong number of arguments (given 1, expected 2)
# >>     /Users/Sonna/Projects/ruby/toy-robot/v4a-copy-v2/cell.rb:14:in `initialize'
# >>     -:57:in `new'
# >>     -:57:in `test_render_cell_on_screen'
# >>
# >> 1 runs, 0 assertions, 0 failures, 1 errors, 0 skips
