module ToyRobot
  class Cell
    attr_reader :entity
    attr_reader :world

    def initialize(world, entity = nil)
      @entity = entity
      @world = world
    end

    def draw
      entity && entity.draw || "."
    end

    def entity=(value)
      @entity = value
    end

    def occupied?
      entity
    end
  end
end
