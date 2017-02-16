module ToyRobot
  module Input
    class Base
      attr_reader :entity

      # == Example input
      #
      # PLACE X,Y,F
      # MOVE
      # LEFT
      # RIGHT
      # REPORT

      SEPARATORS_REGEX = /[,\s]/.freeze

      def control(entity)
        @entity = entity
      end

      def update
        input, *args = source.chomp.strip.split(SEPARATORS_REGEX)
        entity.process(input, *args)
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
  end
end
