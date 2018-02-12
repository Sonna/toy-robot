module ToyRobot
  module Input
    class Base
      # == Example input
      #
      # PLACE X,Y,F
      # MOVE
      # LEFT
      # RIGHT
      # REPORT

      SEPARATORS_REGEX = /[,\s]/

      def update
        source.chomp.strip.split(SEPARATORS_REGEX)
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
