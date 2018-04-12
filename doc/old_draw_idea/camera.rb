class Camera
  attr_accessor :x, :y #, :zoom
  attr_reader :screen

  def initialize(screen)
    @screen = screen
    # @x = @y = 0
    # @zoom = 1
    @half_screen_height = {}
    @half_screen_width = {}

    @x = half_screen_width
    @y = half_screen_height
  end

  def can_view?(x, y, obj)
    x0, x1, y0, y1 = viewport
    (x0 - obj.width..x1).include?(x) &&
      (y0 - obj.height..y1).include?(y)
  end

  def viewport
    # x0 = @x - (screen.width / 2)  # / @zoom
    # x1 = @x + (screen.width / 2)  # / @zoom
    # y0 = @y - (screen.height / 2) # / @zoom
    # y1 = @y + (screen.height / 2) # / @zoom

    x0 = @x - half_screen_width
    x1 = @x + half_screen_width
    y0 = @y - half_screen_height
    y1 = @y + half_screen_height
    [x0, x1, y0, y1]
  end

  def half_screen_height
    @half_screen_height[screen.height] ||= (screen.height / 2).round # / @zoom
  end

  def half_screen_width
    @half_screen_width[screen.width] ||= (screen.width / 2).round # / @zoom
  end

  # private

  # def relative2camera(obj)
  #   canvas_x = obj.x - x
  #   canvas_y = obj.y - y

  #   Point.new(canvas_x, canvas_y)
  # end

  # def cartesian2screen(position)
  # def cartesian2screen(cartesian)
  def cartesian2screen(obj)
    # screen_x = cartesian.x - half_screen_width
    # screen_y = half_screen_height - cartesian.y
    # screen_x = (obj.x * obj.width_offet) + obj.width_offet - half_screen_width
    # screen_y = half_screen_height - (obj.y * obj.height_offet) + obj.height_offet
    screen_x = obj.x - half_screen_width
    screen_y = half_screen_height - obj.y

    # {x: screen_x, y: screen_y}
    #
    # Cartesian = Struct.new(:x, :y)
    # Cartesian.new(screen_x, screen_y)
    Point.new(screen_x, screen_y)
  end
end
