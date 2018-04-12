class Boundary
  attr_reader :point

  def initialize(point)
    @point = point
  end

  def render
    <<~ASCII
      ┏━┓
      ┃ ┃
      ┗━┛
    ASCII
  end
end
