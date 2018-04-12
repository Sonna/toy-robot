#
# == Example
#   class GameObject
#     include Drawable
#
#     def render
#       <<~ASCII
#         ┏━┓
#         ┃ ┃
#         ┗━┛
#       ASCII
#     end
#   end
module Drawable
  def draw(canvas, max_x, max_y)
    render.each_line.with_index do |line, rowi|
      line.each_char.with_index do |char, coli|
        next if char == "\n"
        x = rowi + position.x - 1
        y = coli + position.y - 1
        canvas[x][y] = char #unless x < 0 || y < 0 || x < max_x || y < max_y
      end
    end
  end

  private

  # def cartesian2screen(position)
  # def cartesian2screen(cartesian, screen_width, screen_height)
  #   screen_x =  cartesian.x - (screen_width  / 2)
  #   screen_y = -cartesian.y + (screen_height / 2)

  #   # {x: screen_x, y: screen_y}
  #   Cartesian = Struct.new(:x, :y)
  #   Cartesian.new(screen_x, screen_y)
  # end
end
