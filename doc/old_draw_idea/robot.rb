# encoding: utf-8

require "forwardable"
require "point"

class Robot
  # include Drawable
  extend Forwardable
  def_delegators :@position, :x, :y

  attr_reader :facing
  attr_reader :position
  attr_reader :height, :width
  attr_reader :world

  DIRECTIONS = {
    "NORTH" => { move: Point.new( 0, 1), left:  "WEST", right:  "EAST" },
    "SOUTH" => { move: Point.new( 0,-1), left:  "EAST", right:  "WEST" },
    "EAST" =>  { move: Point.new( 1, 0), left: "NORTH", right: "SOUTH" },
    "WEST" =>  { move: Point.new(-1, 0), left: "SOUTH", right: "NORTH" }
  }.freeze

  def initialize(object_pool)
    # @world = world
    # @world = object_pool.world
    # @camera = object_pool.camera
    # @screen = object_pool.screen
    @object_pool = object_pool

    @facing = "NORTH"
    @position = Point.new(0, 0)

    @height = 7
    @width = 5

    @height_offset = {}
    @width_offset = {}
    @x = {}
    @y = {}
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

  # <<~ASCII
  #    ↑
  #   ←R→
  #    ↓
  # ASCII
  def render
    n = facing == "NORTH" ? "↑" : " "
    s = facing == "SOUTH" ? "↓" : " "
    e = facing == "EAST"  ? "→" : " "
    w = facing == "WEST"  ? "←" : " "
    <<~ASCII
         #{n}


      #{w}  R  #{e}


         #{s}
    ASCII
  end
  #   n = facing == "NORTH" ? "↓" : " "
  #   s = facing == "SOUTH" ? "↑" : " "
  #   e = facing == "EAST"  ? "←" : " "
  #   w = facing == "WEST"  ? "→" : " "
  #   <<~ASCII
  #        #{s}
  #
  #
  #     #{e}  R  #{w}
  #
  #
  #        #{n}
  #   ASCII
  # end

  # def draw(canvas, offset, max_x, max_y)
  def draw(canvas, max_x, max_y)
    render.each_line.with_index do |line, rowi|
      line.each_char.with_index do |char, coli|
        next if char == "\n" || char == " "
        # pos = cartesian2screen(position, max_x, max_y, offset)
        pos = camera.cartesian2screen(self)

        off_x = -camera.x + camera.half_screen_width
        off_y = -camera.y + camera.half_screen_height

        # _x = coli + pos.x - camera.half_screen_width
        # _y = rowi + pos.y - camera.half_screen_height
        # _x = coli - (pos.x * width_offset) + width_offset
        # _y = rowi - (pos.y * height_offset) + height_offset
        # _x = coli - x + off_x # pos.x
        # _y = rowi - y + off_y # pos.y
        # _x = coli + (camera.screen.width - position.x * width) - 5
        # _y = rowi + (position.y * height) - 2
        # _x = coli - pos.x
        # _y = rowi - pos.y
        # _x = coli + (camera.screen.width - pos.x * width)
        # _y = rowi + (pos.y * height)-2
        # _y = rowi + pos.y - width_offset

        # _x = coli + (position.x * width) - width_offset
        # _y = rowi + (position.y * height) - height_offset
        _x = (width - coli) - position.x - 1
        # _y = camera.screen.height  - position.y - height_offset + rowi
        # _y = pos.y - height_offset + rowi

        # current_column,  half screen height,  y_position, height offset
        # its own height offset? or the cells?
        # _y = coli + (camera.screen.height/2) - position.y + (height/2)
        # _y = (camera.screen.height/2) - (position.y*3) +3
        # _x = (position.x*3) - (camera.screen.width/2) +3

        _x = position.x*3 - (camera.screen.width/2)
        _y = (camera.screen.height/2) - position.y*3

        _x += coli
        _y += rowi

        _x += width
        # _y += height
        _y += height_offset
        # _y -= 3 # cell_width

        p "robot rowi: #{rowi}, coli: #{coli}, x: #{position.x}, y: #{position.y}, _x: #{_x}, _y: #{_y}"
        canvas[_y][_x] = char if camera.can_view?(_x, _y, self)
        # canvas[_x][_y] = char
        # canvas[x][y] = char if camera.can_view?(x, y, self)
      end
    end
  end

  def valid_move?
    # DIRECTIONS[facing][:valid_move?].call(world, self)
    world.valid_move?(self)
  end

  def height_offset
    @height_offset[height] ||= (height/2).round
  end

  def width_offset
    @width_offset[width] ||= (width/2).round
  end

  # def x
  #   @x[width] ||= (position.x * width) + width
  # end

  # def y
  #   @y[height] ||= (position.y * height) + height
  # end

  protected

  attr_reader :object_pool

  def_delegators :@object_pool, :camera, :screen, :world

  private

  # def cartesian2screen(position)
  # def cartesian2screen(cartesian, screen_width, screen_height, offset)
  #   screen_x = (cartesian.x - (screen_width  / 2)) * offset - offset # - 1
  #   screen_y = ((screen_height / 2) - cartesian.y) * offset - offset # - 1

  #   # {x: screen_x, y: screen_y}
  #   #
  #   # Cartesian = Struct.new(:x, :y)
  #   # Cartesian.new(screen_x, screen_y)
  #   Point.new(screen_x, screen_y)
  # end
end
