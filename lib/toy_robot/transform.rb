require "forwardable"
require "toy_robot/vector2d"

module ToyRobot
  class Transform
    extend Forwardable
    def_delegators :@position, :x, :y

    attr_reader :position
    attr_reader :target

    def initialize(position, target = nil) # rotation, scale = 0.0f)
      @position = position
      @target = target || position + Vector2D.up
    end

    def ==(other)
      position == other.position && target == other.target
    end

    def +(other)
      new_position = position + other.position
      new_target = target + other.target

      self.class.new(new_position, new_target)
    end

    # @param translation [Vector2D]
    def translate(translation)
      @position += translation
      @target += translation

      self
    end

    # Positive angle rotations are anti-clockwise, whilst negative angle rotate
    # clockwise (as per convention)
    #
    # CLOCKWISE      = -90 # degrees
    # ANTI_CLOCKWISE =  90 # degrees
    def rotate(angle)
      theta = radians(angle)

      sin = Math.sin(theta)
      cos = Math.cos(theta)

      # translate point back to origin
      translated_point = target - position

      # rotate point
      x = translated_point.x * cos - translated_point.y * sin
      y = translated_point.x * sin + translated_point.y * cos

      rotated_point = Vector2D.new(x, y)

      # translate point back
      @target = rotated_point + position

      self
    end

    private

    # http://stackoverflow.com/questions/6327542/convert-degree-to-radians-in-ruby
    def radians(degrees)
      degrees * Math::PI / 180
    end
  end
end
