require "forwardable"
require "set"

class ObjectPool
  include Enumerable
  extend Forwardable

  attr_accessor :objects, :world, :camera

  def_delegators :@objects, :<<, :map

  def initialize
    # @objects = []
    @objects = Set.new
  end

  def each
    return enum_for(:each) unless block_given?
    @objects.each { |game_object| yield game_object }
    self
  end

  # def nearby(object, max_distance)
  #   non_effects.select do |obj|
  #     obj != object &&
  #       (obj.x - object.x).abs < max_distance &&
  #       (obj.y - object.y).abs < max_distance &&
  #       Utils.distance_between(obj.x, obj.y, object.x, object.y) < max_distance
  #   end
  # end

  # def non_effects
  #   @objects.reject(&:effect?)
  # end
end
