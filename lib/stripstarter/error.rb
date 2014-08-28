module Stripstarter
  module Error

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
  end
end