module ToyRobot
  class App
    def self.run(*args)
      new(*args).run
    end

    def initialize(filename = nil)
      @quiting = false
      @rendering = false

      @input =
        filename ? Input::FileInput.new(filename) : Input::PlayerInput.new
      @scene = table = Grid.new
      @player_character = Robot.new(table)
      @player_controller =
        Controller::PlayerController.new(self, input, player_character)
    end

    def quit!
      @quiting = true
    end

    def run
      loop do
        command = player_controller.handle_input
        render
        break if quiting
      end
    end

    def render!
      @rendering = true
    end

    private

    attr_reader :input
    attr_reader :player_character
    attr_reader :player_controller
    attr_reader :quiting
    attr_reader :rendering
    attr_reader :scene

    def render
      puts scene.draw if rendering
      @rendering = false
    end
  end
end
