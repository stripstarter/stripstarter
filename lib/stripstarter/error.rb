module Stripstarter
  class Error < StandardError

  # Should we have one main error class?
  #
  # class StripstarterError < StandardError
  #   def initialize(msg = nil)
  #     super(msg)
  #   end
  # end

    class UserMismatch
      def initialize(msg = "User mismatch event")
        super(msg)
      end
    end
  end
end