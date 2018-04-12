class Grid
  MAX = 5
  MIN = 0

  attr_reader :max, :min

  def initialize(object_pool = nil, min = MIN, max = MAX)
    # @components = []
    @object_pool = object_pool
    # @object_pool.objects << self

    @min = min
    @max = max

    range = (min...max).to_a
    # @points = Set.new range.product(range).map { |x, y| Point.new(x, y) }
    @points = Set.new range.product(range).map { |x, y| Cell.new(object_pool, Point.new(x, y)) }
    # @object_pool.objects << @points
    @object_pool.objects.merge @points

    # range = (min - 1)..(max + 1)
    outside_min = min - 1 # -1
    outside_max = max + 1 # +6

    @boundary = Set.new
    range = (min..max).to_a
    range.each do |number|
      # Outer Edges
      @boundary << Point.new(number, outside_max) # top
      @boundary << Point.new(outside_max, number) # right
      @boundary << Point.new(number, outside_min) # bottom
      @boundary << Point.new(outside_min, number) # left
    end
  end

  def valid_move?(entity)
    entity.next_move.x >= min &&   # :east
      entity.next_move.x <= max && # :west
      entity.next_move.y >= min && # :north
      entity.next_move.y <= max    # :south
  end

  def draw(canvas, max_x, max_y)
    # render.each_line.with_index do |line, rowi|
    #   line.each_char.with_index do |char, coli|
    #     next if char == "\n"
    #     x = rowi + position.x - 1
    #     y = coli + position.y - 1
    #     canvas[x][y] = char #unless x < 0 || y < 0 || x < max_x || y < max_y
    #   end
    # end
  end

  protected

  attr_reader :object_pool
end
