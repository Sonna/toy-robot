# encoding: utf-8

require "drawable"
require "forwardable"

class Cell
  # include Drawable
  extend Forwardable
  def_delegators :@position, :x, :y

  attr_reader :height, :width
  attr_reader :position

  def initialize(object_pool, point)
    # @camera = object_pool.camera
    @object_pool = object_pool

    @position = point
    @height = 3
    @width = 3

    @height_offset = {}
    @width_offset = {}
    @x = {}
    @y = {}
  end

  def render
    <<~ASCII
      ┏━┓
      ┃#{x+y}┃
      ┗━┛
    ASCII
  end

  # def draw(canvas, offset, max_x, max_y)
  def draw(canvas, max_x, max_y)
    render.each_line.with_index do |line, rowi|
      line.each_char.with_index do |char, coli|
        next if char == "\n"
        pos = camera.cartesian2screen(self)

        off_x = -camera.x + camera.half_screen_width
        off_y = -camera.y + camera.half_screen_height

        # _x = coli + pos.x - camera.half_screen_width
        # _y = rowi + pos.y - camera.half_screen_height
        # _x = coli - (pos.x * width_offset) + width_offset
        # _y = rowi - (pos.y * height_offset) + height_offset
        # _x = coli + x - off_x # pos.x
        # _y = rowi - y + off_y # pos.y
        _x = (camera.screen.width - position.x * width) - width
        _y = (camera.screen.height - position.y * height) - height
        # _x = coli + x
        # _y = rowi + y

        _x = position.x*3 - (camera.screen.width/2)
        _y = (camera.screen.height/2) - position.y*3

        _x += width*2 + 1
        # _x += width_offset
        _y += height*2 - 1
        # _y += height_offset

        _x += coli
        _y += rowi

        canvas[_y][_x] = char if camera.can_view?(_x, _y, self)
        # canvas[_x][_y] = char
        # canvas[x][y] = char if camera.can_view?(x, y, self)
      end
    end
  end

  def height_offset
    @height_offset[height] ||= (height/2).round
  end

  def width_offset
    @width_offset[width] ||= (width/2).round
  end

  def x
    @x[width] ||= (position.x * width) + width
  end

  def y
    @y[height] ||= (position.y * height) + height
  end

  protected

  attr_reader :object_pool

  def_delegators :@object_pool, :camera, :screen, :world

  private

  # def cartesian2screen(cartesian, screen_width, screen_height, offset)
  #   # screen_x = cartesian.x - (screen_width  / 2) # - 1
  #   # screen_y = (screen_height / 2) - cartesian.y # - 1
  #   screen_x = (cartesian.x - (screen_width  / 2)) * offset - offset # - 1
  #   screen_y = ((screen_height / 2) - cartesian.y) * offset + offset # - 1

  #   # {x: screen_x, y: screen_y}
  #   #
  #   # Cartesian = Struct.new(:x, :y)
  #   # Cartesian.new(screen_x, screen_y)
  #   Point.new(screen_x, screen_y)
  # end
end
