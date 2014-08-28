module Stripstarter
  class Error < StandardError

  # Should we have one main error class?
  #
  # class StripstarterError < StandardError
  #   def initialize(msg = nil)
  #     super(msg)
  #   end
  # end

    class UserMismatch < StandardError
      def initialize(msg = "User mismatch event")
        super(msg)
      end
    end

    class Unauthorized < StandardError
      def initialize(msg = "User is not authorized for this resource")
        super(msg)
      end
    end
  end
end