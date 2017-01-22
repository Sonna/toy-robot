# require "toy_robot/input/base"
# require "toy_robot/input/file_input"
# require "toy_robot/input/player_input"

# module ToyRobot
# end

module ToyRobot
  class Input
    attr_reader :entity

    # == Example input
    #
    # PLACE X,Y,F
    # MOVE
    # LEFT
    # RIGHT
    # REPORT
    COMMANDS = {
      "PLACE" => :place,
      "MOVE" => :move,
      "LEFT" => :left,
      "RIGHT" => :right,
      "REPORT" => :report
    }.freeze

    SEPARATORS_REGEX = /[ |,\s*]/.freeze

    def control(entity)
      @entity = entity
    end

    def update
      input, *args = source.chomp.strip.split(SEPARATORS_REGEX)
      command = COMMANDS[input]
      entity.method(command).call(*args) if command
      input
    end

    # @abstract Subclass is expected to implemnet #source
    # @!method source
    #     The Input source; e.g. strings from the User typing into the console
    #     or lines being read from a File
    # def source
    #   raise NoMethodError
    #     .new("#{self.class.name}#source is an abstract method.")
    # end
  end

  class PlayerInput < Input
    def source
      gets
    end
  end

  class FileInput < Input
    attr_reader :file

    def initialize(filename)
      @file = File.new(filename)
    end

    def source
      return "EXIT" if file.eof?
      file.gets
    end
  end
end
