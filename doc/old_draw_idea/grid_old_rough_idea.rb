#!/bin/env ruby
# encoding: utf-8

require "set"
# require "point"
require "/Users/Sonna/Projects/ruby/toy-robot/v4a/point.rb"

class Grid
  MAX = 5
  MIN = 0

  attr_reader :max, :min
  attr_reader :boundary, :points
  attr_reader :cells

  # ref [RubyTapas Episode #459: Array Product](https://www.rubytapas.com/2016/12/08/episode-459-array-product/)
  def initialize(min = MIN, max = MAX)
    @min = min
    @max = max

    range = (min..max).to_a
    @points = Set.new range.product(range).map { |x, y| Point.new(x, y) }

    # range = (min - 1)..(max + 1)
    outside_min = min - 1 # -1
    outside_max = max + 1 # +6

    cells_max = max + 2 # +7

    # rows, cols = x,y  # your values
    # grid = Array.new(rows) { Array.new(cols) }
    # @cells = Array.new(max+3) { Array.new(max+2) }
    @cells = Array.new(cells_max) { Array.new(cells_max) }

    @boundary = Set.new
    range.each do |number|
      # Outer Edges
      @boundary << Point.new(number, outside_max) # top
      @boundary << Point.new(outside_max, number) # right
      @boundary << Point.new(number, outside_min) # bottom
      @boundary << Point.new(outside_min, number) # left

      @cells[number][cells_max] = Point.new(number, outside_max) # top
      @cells[cells_max][number] = Point.new(outside_max, number) # right
      @cells[number][min]       = Point.new(number, outside_min) # bottom
      @cells[min][number]       = Point.new(outside_min, number) # left
    end
  end

  def valid_move?(entity)
    # points.include? entity.next_move
    !boundary.include? entity.next_move
  end


  # int array[width * height];
  #
  # int SetElement(int row, int col, int value)
  # {
  #    array[width * row + col] = value;
  # }
  def render
    # Set.new range.product(range).map { |x, y| Point.new(x, y) }
    boundary_corners = [Point.new(-1, -1), Point.new(-1, 6), Point.new(6, -1), Point.new(6, 6)]
    # map = Set.new(points + boundary).sort
    map = Set.new(points + boundary + boundary_corners).sort

    outer_min = min     # (min - 1)
    outer_max = max + 2 # (max + 1)
    range = (outer_min..outer_max).to_a

    range.product(range).map do |row, col|
      index = (outer_max * row) + col
      point = map[index]
      graphic = boundary.include?(point) ? "*" : "."
      graphic += index % outer_max == 0 ? "\n" : ""
    end.join


    cells.map.with_index do |row, rowi|
      rendered_row = row.map.with_index do |col, coli|
        puts "element [#{rowi}, #{coli}] is #{col}"

        #  tl    top    tr
        #         ^
        #         |
        # left <--+--> right
        #         |
        #         V
        #  bl   bottom  br
        # current_cell = points[row][col]
        top    = cells[rowi][coli+1]
        bottom = cells[rowi][coli-1]
        right  = cells[rowi+1][coli]
        left   = cells[rowi-1][coli]

        # if top
        #   tl = "┣"
        #   tr = "┫"
        #   bl = "┗"
        #   br = "┛"
        # elsif top && left
        #   tl = "╋"
        #   tr = "┫"
        #   bl = "┻"
        #   br = "┛"
        # elsif top && right
        #   tl = "┫"
        #   tr = "╋"
        #   bl = "┛"
        #   br = "┻"
        # elsif left
        # elsif right
        #
        if top
          <<~ASCII
            ┣━┫
            ┃ ┃
            ┗━┛
          ASCII
        elsif top && left
          <<~ASCII
            ╋━┫
            ┃ ┃
            ┻━┛
          ASCII
        elsif top && right
          <<~ASCII
            ┣━╋
            ┃ ┃
            ┗━┻
          ASCII
        elsif bottom
          <<~ASCII
            ┏━┓
            ┃ ┃
            ┣━┫
          ASCII
        elsif bottom && left
          <<~ASCII
            ┳━┓
            ┃ ┃
            ╋━┫
          ASCII
        elsif bottom && right
          <<~ASCII
            ┏━┳
            ┃ ┃
            ┣━╋
          ASCII
        elsif left
          <<~ASCII
            ┳━┓
            ┃ ┃
            ┻━┛
          ASCII
        elsif right
          <<~ASCII
            ┏━┳
            ┃ ┃
            ┗━┻
          ASCII
        end
      end

      splited_rendered_row = rendered_row.map { |r| r.split("\n") } # !> assigned but unused variable - splited_rendered_row
      # =>
    end

    # range.map(&:draw).join
  end

  # private

  # def range
  #   (min..max).to_a
  # end
end

Grid.new.boundary
# =>

Grid.new.render
# =>

# <<~ASCII
#   ┏━┓
#   ┃ ┃
#   ┗━┛
# ASCII
# <<~ASCII
#   ┏━┳━┓
#   ┃ ┃ ┃
#   ┗━┻━┛
# ASCII
# <<~ASCII
#   ┏━┳━┓
#   ┃ ┃ ┃
#   ┣━╋━┫
#   ┃ ┃ ┃
#   ┗━┻━┛
# ASCII
# ~> -:43:in `block in initialize': undefined method `[]=' for nil:NilClass (NoMethodError)
# ~>  from -:35:in `each'
# ~>  from -:35:in `initialize'
# ~>  from -:177:in `new'
# ~>  from -:177:in `<main>'
