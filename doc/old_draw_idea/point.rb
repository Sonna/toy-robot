class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x.to_i
    @y = y.to_i
  end

  def +(other)
    Point.new(x + other.x, y + other.y)
  end

  # [
  #   [(0,1), (1,1)],
  #   [(0,0), (1,0)]
  # ]
  #
  # [(0,0), (1,0), (0,1)]
  def <=>(other)
    if x == other.x && y == other.y
      0
    # elsif (x < other.x && y == other.y) || (x == other.x && y < other.y) || (x < other.x && y < other.y) || (x < other.x && y > other.y)
    elsif (x < other.x && y == other.y) || (x == other.x && y > other.y) || (x < other.x && y < other.y) || (x < other.x && y > other.y)
      -1
    # elsif (x < other.x && y == other.y) || (x == other.x && y > other.y) || (x < other.x && y < other.y) || (x < other.x && y > other.y)
    elsif (x > other.x && y == other.y) || (x == other.x && y < other.y) || (x > other.x && y > other.y) || (x > other.x && y < other.y)
      1
    end
  end

  def to_s
    "#{x},#{y}"
  end

  #         0 1 2 3 4 5 6 7 8 9 A B C D E F
  # U+250x  ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉ ┊ ┋ ┌ ┍ ┎ ┏
  # U+251x  ┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ┚ ┛ ├ ┝ ┞ ┟
  # U+252x  ┠ ┡ ┢ ┣ ┤ ┥ ┦ ┧ ┨ ┩ ┪ ┫ ┬ ┭ ┮ ┯
  # U+253x  ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┺ ┻ ┼ ┽ ┾ ┿
  # U+254x  ╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ╊ ╋ ╌ ╍ ╎ ╏
  # U+255x  ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ ╚ ╛ ╜ ╝ ╞ ╟
  # U+256x  ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ╪ ╫ ╬ ╭ ╮ ╯
  # U+257x  ╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╺ ╻ ╼ ╽ ╾ ╿
  def render
    <<~ASCII
      ┏━┓
      ┃ ┃
      ┗━┛
    ASCII
  end
end
