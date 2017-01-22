module ToyRobot
  class App
    def self.run(filename = nil)
      input = filename ? FileInput.new(filename) : PlayerInput.new
      Robot.new(input)

      loop { break if input.update == "EXIT" }
    end
  end
end
