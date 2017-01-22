module ToyRobot
  class App
    def self.run(*args)
      new(*args).run
    end

    def initialize(filename = nil)
      @input = filename ? FileInput.new(filename) : PlayerInput.new
      Robot.new(input)
    end

    def run
      loop { break if input.update == "EXIT" }
    end

    private

    attr_reader :input
  end
end
