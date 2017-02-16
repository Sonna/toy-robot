module ToyRobot
  class App
    def self.run(*args)
      new(*args).run
    end

    def initialize(filename = nil)
      @input =
        filename ? Input::FileInput.new(filename) : Input::PlayerInput.new
      table = Grid.new
      Robot.new(table, input)
    end

    def run
      loop { break if input.update == "EXIT" }
    end

    private

    attr_reader :input
  end
end
