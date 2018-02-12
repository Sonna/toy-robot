require "toy_robot/command"

module ToyRobot
  module Controller
    class PlayerController # < Base
      attr_reader :scene
      attr_reader :input
      attr_reader :entity

      def initialize(scene, input, entity = nil)
        @scene = scene
        @input = input
        @entity = entity
      end

      def handle_input
        command, *args = input.process
        handle(command, *args)
        # app.event_queue << proc { handle(command, *args) }
      end

      def commands
        draw = Command::App::DrawCommand.new(scene)
        quit = Command::App::ExitCommand.new(scene)

        place = Command::Entity::PlaceCommand.new(entity)
        move = Command::Entity::MoveCommand.new(entity)
        left = Command::Entity::LeftCommand.new(entity)
        right = Command::Entity::RightCommand.new(entity)
        report = Command::Entity::ReportCommand.new(entity)

        no_action = Command::NoActionCommand.new(self)

        [draw, quit, place, move, left, right, report, no_action]
      end

      def command_for_input(input)
        commands.find { |command| command.match?(input) }
      end

      def handle(input, *args)
        command_for_input(input).execute(*args)
      end
    end
  end
end
